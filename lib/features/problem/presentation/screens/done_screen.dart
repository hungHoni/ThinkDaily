import 'package:flutter/material.dart';
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('Nicely done.', style: AppTextStyles.doneMessage),
              const SizedBox(height: AppSpacing.xxl),
              _StatRow(label: 'DAY STREAK', value: '$streak'),
              const SizedBox(height: AppSpacing.lg),
              _StatRow(label: 'XP TOTAL', value: '$xp'),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text('Back to Home', style: AppTextStyles.buttonLabel),
                ),
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
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(value, style: AppTextStyles.appTitle),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTextStyles.categoryLabel),
      ],
    );
  }
}
