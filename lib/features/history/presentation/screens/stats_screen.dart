import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/history/data/sources/streak_service.dart';
import 'package:think_daily/features/history/data/sources/xp_service.dart';
import 'package:think_daily/features/history/presentation/providers/stats_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakServiceProvider);
    final xpAsync = ref.watch(xpServiceProvider);
    final statsAsync = ref.watch(statsDataProvider);

    final isLoading =
        streakAsync.isLoading || xpAsync.isLoading || statsAsync.isLoading;
    final hasError =
        streakAsync.hasError || xpAsync.hasError || statsAsync.hasError;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: AppSpacing.pagePadding,
              child: Row(
                children: [
                  Expanded(child: Text('Stats', style: AppTextStyles.appTitle)),
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close, color: AppColors.text),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            if (isLoading)
              const Expanded(child: SizedBox.shrink())
            else if (hasError)
              Expanded(
                child: Center(
                  child: Text(
                    'Could not load stats.',
                    style: AppTextStyles.categoryLabel,
                  ),
                ),
              )
            else
              _StatsBody(
                streak: streakAsync.value!,
                xp: xpAsync.value!,
                stats: statsAsync.value!,
              ),
          ],
        ),
      ),
    );
  }
}

class _StatsBody extends StatelessWidget {
  const _StatsBody({
    required this.streak,
    required this.xp,
    required this.stats,
  });

  final StreakService streak;
  final XpService xp;
  final StatsData stats;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // Streak
            Text('STREAK', style: AppTextStyles.categoryLabel),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _BigStat(value: '${streak.count}', label: 'CURRENT'),
                const SizedBox(width: AppSpacing.xl),
                _BigStat(value: '${streak.best}', label: 'BEST'),
              ],
            ),

            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.xxl),

            // XP
            Text('EXPERIENCE', style: AppTextStyles.categoryLabel),
            const SizedBox(height: AppSpacing.md),
            _BigStat(value: '${xp.total}', label: 'XP TOTAL'),

            if (stats.unitAccuracy.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xxl),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xxl),

              Text('ACCURACY BY UNIT', style: AppTextStyles.categoryLabel),
              const SizedBox(height: AppSpacing.lg),
              for (final entry in stats.unitAccuracy.entries) ...[
                _UnitAccuracyRow(unitName: entry.key, accuracy: entry.value),
                const SizedBox(height: AppSpacing.md),
              ],
            ],

            if (stats.history.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xxl),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xxl),

              Text('HISTORY', style: AppTextStyles.categoryLabel),
              const SizedBox(height: AppSpacing.lg),
              for (final entry in stats.history.reversed) ...[
                _HistoryRow(
                  date: entry['date'] as String? ?? '',
                  unitName:
                      stats.problemMap[entry['problemId'] as String? ?? ''] ??
                      '—',
                  correct: entry['correct'] as bool? ?? false,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],

            if (stats.history.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xl),
                child: Text(
                  'No questions answered yet.\nComplete your first question to see stats here.',
                  style: AppTextStyles.categoryLabel,
                ),
              ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _BigStat extends StatelessWidget {
  const _BigStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTextStyles.appTitle),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.categoryLabel),
      ],
    );
  }
}

class _UnitAccuracyRow extends StatelessWidget {
  const _UnitAccuracyRow({required this.unitName, required this.accuracy});

  final String unitName;
  final UnitAccuracy accuracy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(unitName, style: AppTextStyles.thinkingPattern)),
        const SizedBox(width: AppSpacing.md),
        Text(
          '${accuracy.correct}/${accuracy.total} (${accuracy.pct}%)',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.date,
    required this.unitName,
    required this.correct,
  });

  final String date;
  final String unitName;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          correct ? '✓' : '×',
          style: AppTextStyles.categoryLabel.copyWith(
            color: correct ? AppColors.text : AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(unitName, style: AppTextStyles.thinkingPattern),
              const SizedBox(height: 2),
              Text(date, style: AppTextStyles.categoryLabel),
            ],
          ),
        ),
      ],
    );
  }
}
