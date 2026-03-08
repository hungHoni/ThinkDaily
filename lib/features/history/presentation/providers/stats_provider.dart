import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:think_daily/features/history/data/sources/progress_service.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';

part 'stats_provider.g.dart';

class UnitAccuracy {
  const UnitAccuracy({required this.correct, required this.total});
  final int correct;
  final int total;
  int get pct => total > 0 ? (correct / total * 100).round() : 0;
}

class StatsData {
  const StatsData({
    required this.history,
    required this.unitAccuracy,
    required this.problemMap,
  });

  final List<Map<String, dynamic>> history;
  final Map<String, UnitAccuracy> unitAccuracy;

  // problemId → unitTitle lookup for history rows
  final Map<String, String> problemMap;
}

@riverpod
Future<StatsData> statsData(Ref ref) async {
  final progressSvc = await ref.watch(progressServiceProvider.future);
  final source = ref.watch(problemLocalSourceProvider);

  final history = progressSvc.getHistory();
  final allProblems = source.getAllProblems();

  final unitTitleById = {for (final p in allProblems) p.id: p.unitTitle};

  final unitAccuracy = <String, UnitAccuracy>{};
  for (final entry in history) {
    final id = entry['problemId'] as String? ?? '';
    final correct = entry['correct'] as bool? ?? false;
    final unitTitle = unitTitleById[id];
    if (unitTitle == null) continue;
    final prev = unitAccuracy[unitTitle] ?? const UnitAccuracy(correct: 0, total: 0);
    unitAccuracy[unitTitle] = UnitAccuracy(
      correct: prev.correct + (correct ? 1 : 0),
      total: prev.total + 1,
    );
  }

  return StatsData(
    history: history,
    unitAccuracy: unitAccuracy,
    problemMap: unitTitleById,
  );
}
