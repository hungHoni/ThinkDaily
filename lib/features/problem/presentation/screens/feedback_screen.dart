import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/core/widgets/word_reveal.dart';
import 'package:think_daily/features/history/data/sources/progress_service.dart';
import 'package:think_daily/features/history/data/sources/streak_service.dart';
import 'package:think_daily/features/history/data/sources/xp_service.dart';
import 'package:think_daily/features/problem/data/models/problem.dart';
import 'package:think_daily/features/problem/data/sources/user_progress_service.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';

class FeedbackScreen extends ConsumerWidget {
  const FeedbackScreen({required this.args, super.key});

  final FeedbackArgs args;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final problem = args.problem;
    final isCorrect = args.answerState.isCorrect ?? false;
    final noAnim = MediaQuery.of(context).disableAnimations;

    // Base delays for staggered reveal
    final explanationDelay = isCorrect
        ? const Duration(milliseconds: 400)
        : const Duration(milliseconds: 750);
    final patternDelay = isCorrect
        ? const Duration(milliseconds: 900)
        : const Duration(milliseconds: 1200);
    final xpDelay = isCorrect
        ? const Duration(milliseconds: 1400)
        : const Duration(milliseconds: 1700);
    final xpLabel = isCorrect ? '+10 XP' : '+5 XP';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacing.pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    // Result label
                    if (noAnim)
                      _ResultLabel(isCorrect: isCorrect)
                    else
                      _ResultLabel(isCorrect: isCorrect)
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 300))
                          .moveY(
                            begin: 8,
                            end: 0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                    const SizedBox(height: AppSpacing.xl),
                    // Correct answer reveal (when wrong)
                    if (!isCorrect) ...[
                      if (noAnim)
                        _CorrectAnswerReveal(problem: problem)
                      else
                        _CorrectAnswerReveal(problem: problem)
                            .animate(
                              delay: const Duration(milliseconds: 350),
                            )
                            .fadeIn(
                              duration: const Duration(milliseconds: 400),
                            )
                            .moveY(
                              begin: 8,
                              end: 0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut,
                            ),
                      const SizedBox(height: AppSpacing.xl),
                    ],
                    // Explanation — word-by-word reveal
                    WordReveal(
                      text: problem.explanation,
                      style: AppTextStyles.explanationBody,
                      baseDelay: explanationDelay,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    // Thinking pattern
                    if (noAnim)
                      Text(
                        'The thinking pattern: ${problem.thinkingPattern}',
                        style: AppTextStyles.thinkingPattern,
                      )
                    else
                      Text(
                        'The thinking pattern: ${problem.thinkingPattern}',
                        style: AppTextStyles.thinkingPattern,
                      )
                          .animate(delay: patternDelay)
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .moveY(
                            begin: 8,
                            end: 0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          ),
                    const SizedBox(height: AppSpacing.lg),
                    // XP earned label
                    if (noAnim)
                      Text(xpLabel, style: AppTextStyles.categoryLabel)
                    else
                      Text(xpLabel, style: AppTextStyles.categoryLabel)
                          .animate(delay: xpDelay)
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .moveY(
                            begin: 6,
                            end: 0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                          ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    unawaited(HapticFeedback.mediumImpact());
                    // Save to history
                    final progressSvc =
                        await ref.read(progressServiceProvider.future);
                    await progressSvc.saveResult(
                      problemId: problem.id,
                      userAnswer: args.answerState.selectedAnswer ?? '',
                      correct: isCorrect,
                    );
                    // Advance curriculum position
                    final userProgressSvc =
                        await ref.read(userProgressServiceProvider.future);
                    final source = ref.read(problemLocalSourceProvider);
                    await userProgressSvc.markCompleted(
                      problem: problem,
                      allProblemsInTrack:
                          source.getProblemsByTrack(problem.trackId),
                    );
                    // Record streak + XP
                    final streakSvc =
                        await ref.read(streakServiceProvider.future);
                    await streakSvc.recordToday();
                    final xpSvc = await ref.read(xpServiceProvider.future);
                    await xpSvc.addXp(isCorrect ? 10 : 5);
                    // Invalidate cached next question so HomeScreen/ProblemScreen refresh
                    ref.invalidate(nextQuestionProvider(problem.trackId));
                    if (!context.mounted) return;
                    ref.read(answerNotifierProvider.notifier).reset();
                    context.go(AppRoutes.done);
                  },
                  child: Text('Done', style: AppTextStyles.buttonLabel),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}

class _ResultLabel extends StatelessWidget {
  const _ResultLabel({required this.isCorrect});

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isCorrect ? 'CORRECT' : 'NOT QUITE',
          style: AppTextStyles.categoryLabel,
        ),
        const SizedBox(height: 6),
        Text(
          isCorrect ? 'Well reasoned.' : "Here's the right answer.",
          style: AppTextStyles.doneMessage,
        ),
      ],
    );
  }
}

class _CorrectAnswerReveal extends StatelessWidget {
  const _CorrectAnswerReveal({required this.problem});

  final Problem problem;

  @override
  Widget build(BuildContext context) {
    if (problem.type == ProblemType.choice) {
      return _ChoiceReveal(problem: problem);
    }
    return _OrderingReveal(problem: problem);
  }
}

class _ChoiceReveal extends StatelessWidget {
  const _ChoiceReveal({required this.problem});

  final Problem problem;

  @override
  Widget build(BuildContext context) {
    final correctIndex = problem.correctAnswer as int;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.invertedBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              problem.options[correctIndex],
              style: AppTextStyles.optionTextInverted,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderingReveal extends StatelessWidget {
  const _OrderingReveal({required this.problem});

  final Problem problem;

  @override
  Widget build(BuildContext context) {
    final correctOrder = problem.correctAnswer as List<int>;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Correct order:', style: AppTextStyles.categoryLabel),
              const SizedBox(height: AppSpacing.sm),
              for (var i = 0; i < correctOrder.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Text(
                    '${i + 1}. ${problem.options[correctOrder[i]]}',
                    style: AppTextStyles.optionText,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
