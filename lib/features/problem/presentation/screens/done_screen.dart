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

class DoneScreen extends ConsumerWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakServiceProvider);
    final xpAsync = ref.watch(xpServiceProvider);

    final streak = streakAsync.valueOrNull?.count ?? 0;
    final xp = xpAsync.valueOrNull?.total ?? 0;
    final noAnim = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // Headline
              if (noAnim)
                Text('Nicely done.', style: AppTextStyles.doneMessage)
              else
                Text('Nicely done.', style: AppTextStyles.doneMessage)
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .moveY(
                      begin: 12,
                      end: 0,
                      duration: 500.ms,
                      curve: Curves.easeOut,
                    ),

              const SizedBox(height: AppSpacing.xxl),

              // Streak stat
              if (noAnim)
                _StatRow(label: 'DAY STREAK', value: streak)
              else
                _StatRow(label: 'DAY STREAK', value: streak)
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 400.ms)
                    .moveY(
                      begin: 8,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),

              const SizedBox(height: AppSpacing.lg),

              // XP stat
              if (noAnim)
                _StatRow(label: 'XP TOTAL', value: xp)
              else
                _StatRow(label: 'XP TOTAL', value: xp)
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 400.ms)
                    .moveY(
                      begin: 8,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),

              // Streak milestone note
              if (streak > 0 && streak % 7 == 0) ...[
                const SizedBox(height: AppSpacing.md),
                if (noAnim)
                  Text(
                    '$streak day milestone.',
                    style: AppTextStyles.categoryLabel,
                  )
                else
                  Text(
                    '$streak day milestone.',
                    style: AppTextStyles.categoryLabel,
                  )
                      .animate(delay: 700.ms)
                      .fadeIn(duration: 400.ms),
              ],

              const Spacer(flex: 2),

              if (noAnim)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text('Back to Home', style: AppTextStyles.buttonLabel),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text('Back to Home', style: AppTextStyles.buttonLabel),
                  ),
                )
                    .animate(delay: 700.ms)
                    .fadeIn(duration: 400.ms)
                    .moveY(
                      begin: 8,
                      end: 0,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOut,
          builder: (context, animatedValue, _) {
            return Text('$animatedValue', style: AppTextStyles.appTitle);
          },
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTextStyles.categoryLabel),
      ],
    );
  }
}
