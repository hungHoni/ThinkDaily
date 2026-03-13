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
            // ── Header ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
                AppSpacing.screenHorizontal,
                AppSpacing.lg,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('Stats', style: AppTextStyles.appTitle),
                  ),
                  GestureDetector(
                    onTap: () => context.canPop()
                        ? context.pop()
                        : context.go(AppRoutes.home),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      child: Icon(
                        Icons.close,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Body
// ─────────────────────────────────────────────────────────────────────────────

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

    // Overall accuracy across all units
    int totalCorrect = 0;
    int totalAnswered = 0;
    for (final entry in accuracyEntries) {
      totalCorrect += entry.value.correct;
      totalAnswered += entry.value.total;
    }
    final overallPct =
        totalAnswered > 0 ? (totalCorrect / totalAnswered * 100).round() : 0;

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xl),

            // ── Streak + XP row ────────────────────────────────────────
            _animIf(
              noAnim: noAnim,
              delay: Duration.zero,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _StatTile(
                      label: 'STREAK',
                      value: '${streak.count}',
                      sublabel: 'days',
                      showFlame: streak.count > 0,
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatTile(
                      label: 'BEST',
                      value: '${streak.best}',
                      sublabel: 'days',
                    ),
                  ),
                  _VerticalDivider(),
                  Expanded(
                    child: _StatTile(
                      label: 'XP',
                      value: '${xp.total}',
                      sublabel: 'total',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xl),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSpacing.xl),

            // ── Overall accuracy ───────────────────────────────────────
            if (totalAnswered > 0) ...[
              _animIf(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 120),
                child: _OverallAccuracyRow(
                  pct: overallPct,
                  correct: totalCorrect,
                  total: totalAnswered,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xl),
            ],

            // ── Accuracy by unit ───────────────────────────────────────
            if (accuracyEntries.isNotEmpty) ...[
              Text('ACCURACY BY UNIT', style: AppTextStyles.categoryLabel),
              const SizedBox(height: AppSpacing.lg),
              for (var i = 0; i < accuracyEntries.length; i++) ...[
                _animIf(
                  noAnim: noAnim,
                  delay: Duration(milliseconds: 160 + 80 * i),
                  child: _UnitAccuracyRow(
                    unitName: accuracyEntries[i].key,
                    accuracy: accuracyEntries[i].value,
                  ),
                ),
                if (i < accuracyEntries.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Divider(height: 1, color: AppColors.border),
                  )
                else
                  const SizedBox(height: AppSpacing.xl),
              ],
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xl),
            ],

            // ── History link ───────────────────────────────────────────
            _animIf(
              noAnim: noAnim,
              delay: const Duration(milliseconds: 300),
              child: _HistoryLink(stats: stats),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  /// Wraps [child] in a fade+slide animation unless [noAnim] is true.
  Widget _animIf({
    required bool noAnim,
    required Duration delay,
    required Widget child,
  }) {
    if (noAnim) return child;
    return child
        .animate(delay: delay)
        .fadeIn(duration: 400.ms)
        .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat tile — used in the top row (streak, best, xp)
// ─────────────────────────────────────────────────────────────────────────────

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.sublabel,
    this.showFlame = false,
  });

  final String label;
  final String value;
  final String sublabel;
  final bool showFlame;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.categoryLabel),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.appTitle.copyWith(
                  fontSize: 32,
                  letterSpacing: 0,
                ),
              ),
              if (showFlame) ...[
                const SizedBox(width: AppSpacing.xs),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '🔥',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(sublabel, style: AppTextStyles.categoryLabel),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Thin vertical divider between stat tiles
// ─────────────────────────────────────────────────────────────────────────────

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: AppColors.border,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Overall accuracy — large display with a thick progress bar
// ─────────────────────────────────────────────────────────────────────────────

class _OverallAccuracyRow extends StatelessWidget {
  const _OverallAccuracyRow({
    required this.pct,
    required this.correct,
    required this.total,
  });

  final int pct;
  final int correct;
  final int total;

  @override
  Widget build(BuildContext context) {
    final ratio = pct.clamp(0, 100) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('OVERALL ACCURACY', style: AppTextStyles.categoryLabel),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$pct%',
              style: AppTextStyles.appTitle.copyWith(
                fontSize: 44,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                '$correct of $total correct',
                style: AppTextStyles.categoryLabel,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Thick progress bar
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 4,
                  width: constraints.maxWidth,
                  color: AppColors.border,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  height: 4,
                  width: constraints.maxWidth * ratio,
                  color: AppColors.text,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Unit accuracy row — label + thin bar + fraction
// ─────────────────────────────────────────────────────────────────────────────

class _UnitAccuracyRow extends StatelessWidget {
  const _UnitAccuracyRow({
    required this.unitName,
    required this.accuracy,
  });

  final String unitName;
  final UnitAccuracy accuracy;

  @override
  Widget build(BuildContext context) {
    final pct = accuracy.pct.clamp(0, 100) / 100;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Unit name + percentage
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                unitName,
                style: AppTextStyles.thinkingPattern,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              '${accuracy.pct}%',
              style: AppTextStyles.thinkingPattern.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // Progress bar (thin, 2px)
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
        const SizedBox(height: AppSpacing.xs),
        // Fraction label
        Text(
          '${accuracy.correct} of ${accuracy.total} correct',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// History link
// ─────────────────────────────────────────────────────────────────────────────

class _HistoryLink extends StatelessWidget {
  const _HistoryLink({required this.stats});

  final StatsData stats;

  @override
  Widget build(BuildContext context) {
    final hasHistory = stats.history.isNotEmpty;

    return GestureDetector(
      onTap: hasHistory ? () => context.push(AppRoutes.history) : null,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('HISTORY', style: AppTextStyles.categoryLabel),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    hasHistory
                        ? '${stats.history.length} question${stats.history.length == 1 ? '' : 's'} answered'
                        : 'No questions answered yet.',
                    style: AppTextStyles.thinkingPattern.copyWith(
                      color: hasHistory
                          ? AppColors.text
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (hasHistory) ...[
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.textSecondary,
                  size: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
