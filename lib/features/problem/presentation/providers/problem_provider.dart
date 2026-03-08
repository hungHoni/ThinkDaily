import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/data/sources/problem_local_source.dart';
import 'package:think_daily/features/problem/data/sources/user_progress_service.dart';

part 'problem_provider.g.dart';

// ─── Data source ─────────────────────────────────────────────────────────────

@riverpod
ProblemLocalSource problemLocalSource(Ref ref) => ProblemLocalSource();

// ─── Next problem in curriculum ───────────────────────────────────────────────

@riverpod
Future<Problem?> nextQuestion(Ref ref, String trackId) async {
  final source = ref.read(problemLocalSourceProvider);
  final service = await ref.read(userProgressServiceProvider.future);
  final progress = service.getProgress(trackId);
  final problems = source.getProblemsByTrack(trackId);
  return source.getNextProblem(progress, problems);
}

// ─── Answer state ─────────────────────────────────────────────────────────────

class AnswerState {
  const AnswerState({
    this.selectedAnswer,
    this.submitted = false,
    this.isCorrect,
  });

  final Object? selectedAnswer; // int for choice, List<int> for ordering
  final bool submitted;
  final bool? isCorrect;

  bool get hasSelection => selectedAnswer != null;

  AnswerState copyWith({
    Object? selectedAnswer,
    bool? submitted,
    bool? isCorrect,
    bool clearSelection = false,
  }) {
    return AnswerState(
      selectedAnswer:
          clearSelection ? null : (selectedAnswer ?? this.selectedAnswer),
      submitted: submitted ?? this.submitted,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}

@riverpod
class AnswerNotifier extends _$AnswerNotifier {
  @override
  AnswerState build() => const AnswerState();

  void selectChoice(int index) {
    if (state.submitted) return;
    if (state.selectedAnswer == index) {
      state = state.copyWith(clearSelection: true);
    } else {
      state = state.copyWith(selectedAnswer: index);
    }
  }

  void updateOrdering(List<int> order) {
    if (state.submitted) return;
    state = state.copyWith(selectedAnswer: order);
  }

  void submit(Problem problem) {
    if (!state.hasSelection || state.submitted) return;
    final isCorrect = _evaluate(problem);
    state = state.copyWith(submitted: true, isCorrect: isCorrect);
  }

  void reset() {
    state = const AnswerState();
  }

  bool _evaluate(Problem problem) {
    final answer = state.selectedAnswer;
    final correct = problem.correctAnswer;

    if (problem.type == ProblemType.choice) {
      return answer == correct;
    } else {
      if (answer is! List || correct is! List) return false;
      if (answer.length != correct.length) return false;
      for (var i = 0; i < answer.length; i++) {
        if (answer[i] != correct[i]) return false;
      }
      return true;
    }
  }
}
