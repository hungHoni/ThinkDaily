import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
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
    final noAnim = MediaQuery.of(context).disableAnimations;
    final accuracyEntries = stats.unitAccuracy.entries.toList();

    return Expanded(
      child: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // ── Streak ──────────────────────────────────────────────
            Text('STREAK', style: AppTextStyles.categoryLabel),
            const SizedBox(height: AppSpacing.md),
            if (noAnim)
              Row(
                children: [
                  _BigStat(value: '${streak.count}', label: 'CURRENT'),
                  const SizedBox(width: AppSpacing.xl),
                  _BigStat(value: '${streak.best}', label: 'BEST'),
                ],
              )
            else
              Row(
                children: [
                  _BigStat(value: '${streak.count}', label: 'CURRENT'),
                  const SizedBox(width: AppSpacing.xl),
                  _BigStat(value: '${streak.best}', label: 'BEST'),
                ],
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut),

            const SizedBox(height: AppSpacing.xxl),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.xxl),

            // ── XP ──────────────────────────────────────────────────
            Text('EXPERIENCE', style: AppTextStyles.categoryLabel),
            const SizedBox(height: AppSpacing.md),
            if (noAnim)
              _BigStat(value: '${xp.total}', label: 'XP TOTAL')
            else
              _BigStat(value: '${xp.total}', label: 'XP TOTAL')
                  .animate(delay: 100.ms)
                  .fadeIn(duration: 400.ms)
                  .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut),

            // ── Accuracy by unit ────────────────────────────────────
            if (accuracyEntries.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xxl),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xxl),

              Text('ACCURACY BY UNIT', style: AppTextStyles.categoryLabel),
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < accuracyEntries.length; i++) ...[
                if (noAnim)
                  _UnitAccuracyRow(
                    unitName: accuracyEntries[i].key,
                    accuracy: accuracyEntries[i].value,
                  )
                else
                  _UnitAccuracyRow(
                    unitName: accuracyEntries[i].key,
                    accuracy: accuracyEntries[i].value,
                  )
                      .animate(delay: Duration(milliseconds: 80 * i))
                      .fadeIn(duration: 300.ms)
                      .moveY(begin: 6, end: 0, duration: 300.ms, curve: Curves.easeOut),
                const SizedBox(height: AppSpacing.xl),
              ],
            ],

            // ── History link ─────────────────────────────────────────
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.xxl),
            GestureDetector(
              onTap: stats.history.isEmpty
                  ? null
                  : () => context.push(AppRoutes.history),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('HISTORY', style: AppTextStyles.categoryLabel),
                        const SizedBox(height: 4),
                        Text(
                          stats.history.isEmpty
                              ? 'No questions answered yet.'
                              : '${stats.history.length} question${stats.history.length == 1 ? '' : 's'} answered',
                          style: AppTextStyles.trackTitle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (stats.history.isNotEmpty)
                    Text(
                      '→',
                      style: AppTextStyles.categoryLabel.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
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
    final pct = accuracy.pct.clamp(0, 100) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(unitName, style: AppTextStyles.thinkingPattern),
            ),
            const SizedBox(width: AppSpacing.md),
            Text('${accuracy.pct}%', style: AppTextStyles.categoryLabel),
          ],
        ),
        const SizedBox(height: 8),
        // Progress bar
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 2,
                  width: constraints.maxWidth,
                  color: AppColors.border,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  height: 2,
                  width: constraints.maxWidth * pct,
                  color: AppColors.text,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          '${accuracy.correct} of ${accuracy.total} correct',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}
