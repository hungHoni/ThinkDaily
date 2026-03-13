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
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Expanded(child: Text('Stats', style: AppTextStyles.appTitle)),
                  GestureDetector(
                    onTap: () => context.canPop()
                        ? context.pop()
                        : context.go(AppRoutes.home),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: AppColors.text,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

            if (isLoading)
              const Expanded(child: _LoadingState())
            else if (hasError)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppColors.border,
                        size: 40,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Could not load stats.',
                        style: AppTextStyles.categoryLabel,
                      ),
                    ],
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

// ── Loading skeleton ──────────────────────────────────────────────────────────

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          _SkeletonBox(width: 80, height: 11),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _SkeletonBox(width: 100, height: 80),
              const SizedBox(width: AppSpacing.lg),
              _SkeletonBox(width: 100, height: 80),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          _SkeletonBox(width: 120, height: 11),
          const SizedBox(height: AppSpacing.md),
          _SkeletonBox(width: double.infinity, height: 88),
          const SizedBox(height: AppSpacing.lg),
          _SkeletonBox(width: double.infinity, height: 60),
          const SizedBox(height: AppSpacing.sm),
          _SkeletonBox(width: double.infinity, height: 60),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == double.infinity ? null : width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(6),
      ),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 800.ms)
        .then()
        .fadeOut(duration: 800.ms);
  }
}

// ── Body ──────────────────────────────────────────────────────────────────────

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

    Widget maybeAnimate(Widget child, {int delayMs = 0}) {
      if (noAnim) return child;
      return child
          .animate(delay: Duration(milliseconds: delayMs))
          .fadeIn(duration: 400.ms)
          .moveY(begin: 10, end: 0, duration: 400.ms, curve: Curves.easeOut);
    }

    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.xl),

            // ── Streak section ─────────────────────────────────────────────
            maybeAnimate(
              _SectionLabel(label: 'STREAK'),
              delayMs: 0,
            ),
            const SizedBox(height: AppSpacing.md),
            maybeAnimate(
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '${streak.count}',
                      label: 'CURRENT',
                      icon: Icons.local_fire_department_outlined,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _StatCard(
                      value: '${streak.best}',
                      label: 'BEST',
                      icon: Icons.emoji_events_outlined,
                    ),
                  ),
                ],
              ),
              delayMs: 60,
            ),

            const SizedBox(height: AppSpacing.xl),

            // ── XP section ────────────────────────────────────────────────
            maybeAnimate(
              _SectionLabel(label: 'EXPERIENCE'),
              delayMs: 120,
            ),
            const SizedBox(height: AppSpacing.md),
            maybeAnimate(
              _XpCard(xp: xp),
              delayMs: 180,
            ),

            // ── Accuracy by unit ──────────────────────────────────────────
            if (accuracyEntries.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xl),
              maybeAnimate(
                _SectionLabel(label: 'ACCURACY BY UNIT'),
                delayMs: 240,
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < accuracyEntries.length; i++) ...[
                      maybeAnimate(
                        _UnitAccuracyRow(
                          unitName: accuracyEntries[i].key,
                          accuracy: accuracyEntries[i].value,
                          isLast: i == accuracyEntries.length - 1,
                        ),
                        delayMs: 280 + 60 * i,
                      ),
                    ],
                  ],
                ),
              ),
            ],

            // ── History link ──────────────────────────────────────────────
            const SizedBox(height: AppSpacing.xl),
            maybeAnimate(
              _HistoryCard(stats: stats),
              delayMs: accuracyEntries.isEmpty ? 240 : 300 + 60 * accuracyEntries.length,
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyles.categoryLabel);
  }
}

// ── Stat card (streak tiles) ──────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 18),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.appTitle.copyWith(
              fontSize: 36,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: AppTextStyles.categoryLabel),
        ],
      ),
    );
  }
}

// ── XP card ───────────────────────────────────────────────────────────────────

class _XpCard extends StatelessWidget {
  const _XpCard({required this.xp});

  final XpService xp;

  @override
  Widget build(BuildContext context) {
    // Determine a rough "level" tier for display
    final total = xp.total;
    final tier = total < 100
        ? 'Beginner'
        : total < 500
            ? 'Practitioner'
            : total < 1500
                ? 'Analyst'
                : 'Expert';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.invertedBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$total XP',
                  style: AppTextStyles.appTitle.copyWith(
                    color: AppColors.invertedText,
                    fontSize: 32,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tier.toUpperCase(),
                  style: AppTextStyles.categoryLabel.copyWith(
                    color: AppColors.invertedText.withOpacity(0.55),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.invertedText.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.bolt_outlined,
              color: AppColors.invertedText,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Unit accuracy row ─────────────────────────────────────────────────────────

class _UnitAccuracyRow extends StatelessWidget {
  const _UnitAccuracyRow({
    required this.unitName,
    required this.accuracy,
    required this.isLast,
  });

  final String unitName;
  final UnitAccuracy accuracy;
  final bool isLast;

  Color _barColor(int pct) {
    if (pct >= 80) return const Color(0xFF2D8653); // green
    if (pct >= 50) return const Color(0xFFB07D2B); // amber
    return const Color(0xFFB03030); // red
  }

  @override
  Widget build(BuildContext context) {
    final pct = accuracy.pct.clamp(0, 100);
    final fraction = pct / 100;
    final barColor = _barColor(pct);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(unitName, style: AppTextStyles.thinkingPattern),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '$pct%',
                    style: AppTextStyles.categoryLabel.copyWith(
                      color: barColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Progress bar — thicker and colored
              LayoutBuilder(
                builder: (context, constraints) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Stack(
                      children: [
                        Container(
                          height: 4,
                          width: constraints.maxWidth,
                          color: AppColors.border,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOut,
                          height: 4,
                          width: constraints.maxWidth * fraction,
                          color: barColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 6),
              Text(
                '${accuracy.correct} of ${accuracy.total} correct',
                style: AppTextStyles.categoryLabel,
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, indent: 18, endIndent: 18, color: AppColors.border),
      ],
    );
  }
}

// ── History card ──────────────────────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.stats});

  final StatsData stats;

  @override
  Widget build(BuildContext context) {
    final hasHistory = stats.history.isNotEmpty;
    final countLabel = hasHistory
        ? '${stats.history.length} question${stats.history.length == 1 ? '' : 's'} answered'
        : 'No questions answered yet.';

    return GestureDetector(
      onTap: hasHistory ? () => context.push(AppRoutes.history) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.history_outlined,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('HISTORY', style: AppTextStyles.categoryLabel),
                  const SizedBox(height: 3),
                  Text(
                    countLabel,
                    style: AppTextStyles.thinkingPattern.copyWith(
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            if (hasHistory)
              const Icon(
                Icons.arrow_forward,
                color: AppColors.textSecondary,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
