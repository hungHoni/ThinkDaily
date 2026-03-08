import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/data/models/user_progress.dart';

part 'user_progress_service.g.dart';

@riverpod
Future<UserProgressService> userProgressService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return UserProgressService(prefs);
}

class UserProgressService {
  UserProgressService(this._prefs);

  final SharedPreferences _prefs;

  String _key(String trackId) => 'user_progress_$trackId';

  String get _today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  UserProgress getProgress(String trackId) {
    final raw = _prefs.getString(_key(trackId));
    if (raw == null) return UserProgress(trackId: trackId);
    return UserProgress.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  Future<void> saveProgress(UserProgress progress) async {
    await _prefs.setString(
      _key(progress.trackId),
      jsonEncode(progress.toJson()),
    );
  }

  bool hasCompletedToday(String trackId) {
    final progress = getProgress(trackId);
    return progress.lastCompletedDate == _today;
  }

  /// Marks [problem] complete and advances the cursor to the next problem.
  Future<void> markCompleted({
    required Problem problem,
    required List<Problem> allProblemsInTrack,
  }) async {
    final progress = getProgress(problem.trackId);
    final completedIds = [...progress.completedIds, problem.id];

    // Sort by unit then question to find the next position
    final sorted = [...allProblemsInTrack]
      ..sort((a, b) {
        final u = a.unitIndex.compareTo(b.unitIndex);
        return u != 0 ? u : a.questionIndex.compareTo(b.questionIndex);
      });

    final currentIdx = sorted.indexWhere((p) => p.id == problem.id);
    var nextUnit = problem.unitIndex;
    var nextQuestion = problem.questionIndex;

    if (currentIdx >= 0 && currentIdx < sorted.length - 1) {
      final next = sorted[currentIdx + 1];
      nextUnit = next.unitIndex;
      nextQuestion = next.questionIndex;
    }

    await saveProgress(
      UserProgress(
        trackId: problem.trackId,
        currentUnitIndex: nextUnit,
        currentQuestionIndex: nextQuestion,
        completedIds: completedIds,
        lastCompletedDate: _today,
      ),
    );
  }
}
