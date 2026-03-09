import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/history/presentation/providers/stats_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(statsDataProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Text(
                          '←',
                          style: AppTextStyles.categoryLabel.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text('History', style: AppTextStyles.appTitle),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.border),

                statsAsync.when(
                  loading: () => const Expanded(child: SizedBox.shrink()),
                  error: (_, __) => Expanded(
                    child: Center(
                      child: Text(
                        'Could not load history.',
                        style: AppTextStyles.categoryLabel,
                      ),
                    ),
                  ),
                  data: (stats) => _HistoryBody(stats: stats),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryBody extends StatelessWidget {
  const _HistoryBody({required this.stats});

  final StatsData stats;

  @override
  Widget build(BuildContext context) {
    final problemById = stats.problemById;

    if (stats.history.isEmpty) {
      return Expanded(
        child: Center(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Text(
              'No questions answered yet.\nComplete your first question to see history here.',
              style: AppTextStyles.categoryLabel,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    final reversed = stats.history.reversed.toList();

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: reversed.length,
        separatorBuilder: (_, __) =>
            const Divider(height: 1, color: AppColors.border),
        itemBuilder: (context, i) {
          final entry = reversed[i];
          final problemId = entry['problemId'] as String? ?? '';
          final correct = entry['correct'] as bool? ?? false;
          final date = entry['date'] as String? ?? '';
          final problem = problemById[problemId];
          final unitName =
              problem?.unitTitle ?? stats.problemMap[problemId] ?? '—';

          return _HistoryRow(
            unitName: unitName,
            date: date,
            correct: correct,
            onTap: problem == null
                ? null
                : () => context.push(
                      AppRoutes.review,
                      extra: ReviewArgs(entry: entry, problem: problem),
                    ),
          );
        },
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.unitName,
    required this.date,
    required this.correct,
    required this.onTap,
  });

  final String unitName;
  final String date;
  final bool correct;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // ✓ / × indicator
            SizedBox(
              width: 20,
              child: Text(
                correct ? '✓' : '×',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: correct ? AppColors.text : AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Unit name + date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(unitName, style: AppTextStyles.trackTitle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
                  const SizedBox(height: 2),
                  Text(date, style: AppTextStyles.categoryLabel),
                ],
              ),
            ),
            // Arrow — only if tappable
            if (onTap != null)
              Text(
                '→',
                style: AppTextStyles.categoryLabel.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
