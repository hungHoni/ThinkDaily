import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/core/widgets/word_reveal.dart';
import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';
import 'package:think_daily/features/problem/presentation/widgets/choice_options.dart';
import 'package:think_daily/features/problem/presentation/widgets/ordering_widget.dart';
import 'package:think_daily/features/problem/presentation/widgets/submit_button.dart';

// Default track for Phase 2a — will be dynamic in Phase 2b (HomeScreen)
const _defaultTrackId = 'problem-decomposition';

class ProblemScreen extends ConsumerWidget {
  const ProblemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProblem = ref.watch(nextQuestionProvider(_defaultTrackId));

    return asyncProblem.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.shrink(),
      ),
      error: (_, __) => const Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.shrink(),
      ),
      data: (problem) {
        if (problem == null) return _NoProblemsLeft();
        return _ProblemView(problem: problem);
      },
    );
  }
}

class _NoProblemsLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Center(
            child: Text(
              'Track complete.\nCheck back tomorrow.',
              style: AppTextStyles.doneMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProblemView extends ConsumerWidget {
  const _ProblemView({required this.problem});

  final Problem problem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerState = ref.watch(answerNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
              ),
              child: MediaQuery.of(context).disableAnimations
                  ? Text(problem.unitTitle, style: AppTextStyles.categoryLabel)
                  : Text(problem.unitTitle, style: AppTextStyles.categoryLabel)
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 400))
                      .moveY(
                        begin: 8,
                        end: 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.sm,
                AppSpacing.screenHorizontal,
                AppSpacing.xl,
              ),
              child: WordReveal(
                text: problem.prompt,
                style: AppTextStyles.problemPrompt,
                baseDelay: const Duration(milliseconds: 100),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: SingleChildScrollView(
                child: _AnswerSection(
                  problem: problem,
                  answerState: answerState,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.md),
            SubmitButton(
              visible: answerState.hasSelection,
              onPressed: () {
                ref.read(answerNotifierProvider.notifier).submit(problem);
                context.push(
                  AppRoutes.feedback,
                  extra: FeedbackArgs(
                    problem: problem,
                    answerState: ref.read(answerNotifierProvider),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _AnswerSection extends ConsumerWidget {
  const _AnswerSection({
    required this.problem,
    required this.answerState,
  });

  final Problem problem;
  final AnswerState answerState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (problem.type == ProblemType.choice) {
      return ChoiceOptions(
        options: problem.options,
        selectedIndex: answerState.selectedAnswer as int?,
        onSelect: (i) =>
            ref.read(answerNotifierProvider.notifier).selectChoice(i),
        disabled: answerState.submitted,
      );
    }

    return OrderingWidget(
      options: problem.options,
      onOrderChanged: (order) =>
          ref.read(answerNotifierProvider.notifier).updateOrdering(order),
      disabled: answerState.submitted,
    );
  }
}
