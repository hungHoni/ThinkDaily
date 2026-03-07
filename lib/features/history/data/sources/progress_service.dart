import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'progress_service.g.dart';

@riverpod
Future<ProgressService> progressService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return ProgressService(prefs);
}

class ProgressService {
  ProgressService(this._prefs);

  final SharedPreferences _prefs;

  static const _completedDatesKey = 'completed_dates';
  static const _historyKey = 'history';

  String get _today => DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool hasCompletedToday() {
    final dates = _getCompletedDates();
    return dates.contains(_today);
  }

  List<String> _getCompletedDates() {
    return _prefs.getStringList(_completedDatesKey) ?? [];
  }

  Future<void> saveResult({
    required String problemId,
    required Object userAnswer,
    required bool correct,
  }) async {
    // Save completed date
    final dates = _getCompletedDates();
    if (!dates.contains(_today)) {
      await _prefs.setStringList(_completedDatesKey, [...dates, _today]);
    }

    // Save history entry
    final history = getHistory();
    final entry = {
      'date': _today,
      'problemId': problemId,
      'userAnswer': userAnswer is List ? userAnswer : userAnswer,
      'correct': correct,
    };
    history.add(entry);
    await _prefs.setString(_historyKey, jsonEncode(history));
  }

  List<Map<String, dynamic>> getHistory() {
    final raw = _prefs.getString(_historyKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.cast<Map<String, dynamic>>();
  }
}
