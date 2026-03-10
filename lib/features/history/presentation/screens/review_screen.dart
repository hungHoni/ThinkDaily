import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/problem/data/models/problem.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({required this.args, super.key});

  final ReviewArgs args;

  @override
  Widget build(BuildContext context) {
    final problem = args.problem;
    final entry = args.entry;
    final userAnswer = entry['userAnswer'];
    final correct = entry['correct'] as bool? ?? false;
    final date = entry['date'] as String? ?? '';

    // Resolve correct and user answer text for display
    final String correctText;
    final String? userText;

    if (problem.type == ProblemType.choice) {
      final correctIdx = problem.correctAnswer is int
          ? problem.correctAnswer as int
          : 0;
      correctText = problem.options[correctIdx];

      final userIdx = userAnswer is int
          ? userAnswer
          : (userAnswer is num ? userAnswer.toInt() : null);
      userText = (!correct && userIdx != null && userIdx < problem.options.length)
          ? problem.options[userIdx]
          : null;
    } else {
      // Ordering — show numbered list as a single string
      final correctOrder = problem.correctAnswer is List
          ? (problem.correctAnswer as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList()
          : <int>[];
      correctText = correctOrder
          .asMap()
          .entries
          .map((e) => '${e.key + 1}. ${problem.options[e.value]}')
          .join('\n');

      if (!correct && userAnswer is List) {
        final userOrder = userAnswer
            .map((e) => (e as num).toInt())
            .toList();
        userText = userOrder
            .asMap()
            .entries
            .map((e) => '${e.key + 1}. ${problem.options[e.value]}')
            .join('\n');
      } else {
        userText = null;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.canPop()
                            ? context.pop()
                            : context.go(AppRoutes.history),
                        child: Text(
                          '←',
                          style: AppTextStyles.categoryLabel.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        correct ? '✓ CORRECT' : '× INCORRECT',
                        style: AppTextStyles.sectionLabel.copyWith(
                          color: correct
                              ? AppColors.text
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Scrollable body ──────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.md),

                        // Unit + difficulty
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.screenHorizontal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                problem.unitTitle.toUpperCase(),
                                style: AppTextStyles.sectionLabel,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                problem.difficulty.label,
                                style: AppTextStyles.categoryLabel,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Prompt
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.screenHorizontal,
                          ),
                          child: Text(
                            problem.prompt,
                            style: AppTextStyles.problemPrompt,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),
                        const Divider(height: 1, color: AppColors.border),
                        const SizedBox(height: AppSpacing.lg),

                        // ── Correct answer ───────────────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.screenHorizontal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CORRECT ANSWER',
                                style: AppTextStyles.sectionLabel,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                correctText,
                                style: AppTextStyles.explanationBody.copyWith(
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── User's wrong answer (only if incorrect) ──
                        if (userText != null) ...[
                          const SizedBox(height: AppSpacing.lg),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenHorizontal,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'YOUR ANSWER',
                                  style: AppTextStyles.sectionLabel.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  userText,
                                  style: AppTextStyles.explanationBody.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: AppSpacing.lg),
                        const Divider(height: 1, color: AppColors.border),
                        const SizedBox(height: AppSpacing.lg),

                        // ── Explanation ──────────────────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.screenHorizontal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'EXPLANATION',
                                style: AppTextStyles.sectionLabel,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                problem.explanation,
                                style: AppTextStyles.explanationBody,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppSpacing.xl),

                        // ── Thinking pattern + date ──────────────────
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.screenHorizontal,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                problem.thinkingPattern.toUpperCase(),
                                style: AppTextStyles.categoryLabel,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Answered $date',
                                style: AppTextStyles.categoryLabel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
