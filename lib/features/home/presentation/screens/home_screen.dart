import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/history/data/sources/streak_service.dart';
import 'package:think_daily/features/history/data/sources/xp_service.dart';
import 'package:think_daily/features/problem/data/sources/user_progress_service.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';

const _trackId = 'problem-decomposition';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(userProgressServiceProvider);
    final streakAsync = ref.watch(streakServiceProvider);
    final xpAsync = ref.watch(xpServiceProvider);

    if (progressAsync.isLoading ||
        streakAsync.isLoading ||
        xpAsync.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.shrink(),
      );
    }

    if (progressAsync.hasError || streakAsync.hasError || xpAsync.hasError) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.shrink(),
      );
    }

    final progressSvc = progressAsync.value!;
    final streakSvc = streakAsync.value!;
    final xpSvc = xpAsync.value!;
    final source = ref.watch(problemLocalSourceProvider);

    final progress = progressSvc.getProgress(_trackId);
    final units = source.getUnitsForTrack(_trackId);
    final tracks = source.getAllTracks();
    final track = tracks.firstWhere((t) => t.id == _trackId);

    final completedToday = progressSvc.hasCompletedToday(_trackId);
    final currentUnit = units.isNotEmpty && progress.currentUnitIndex < units.length
        ? units[progress.currentUnitIndex]
        : null;
    final completedUnits = progress.currentUnitIndex;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Text('ThinkDaily', style: AppTextStyles.appTitle),
                  ),
                  IconButton(
                    onPressed: () => context.push(AppRoutes.stats),
                    icon: const Icon(
                      Icons.bar_chart_rounded,
                      color: AppColors.textSecondary,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Track + unit info
              Text(
                track.title.toUpperCase(),
                style: AppTextStyles.categoryLabel,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (currentUnit != null)
                Text(currentUnit.title, style: AppTextStyles.thinkingPattern),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Unit ${completedUnits + 1} of ${track.totalUnits}',
                style: AppTextStyles.categoryLabel,
              ),

              const SizedBox(height: AppSpacing.xxl),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: AppSpacing.xxl),

              // Streak + XP
              _StatRow(label: 'DAY STREAK', value: '${streakSvc.count}'),
              const SizedBox(height: AppSpacing.lg),
              _StatRow(label: 'XP TOTAL', value: '${xpSvc.total}'),

              const Spacer(),

              // CTA
              if (completedToday) ...[
                Text(
                  'Come back tomorrow.',
                  style: AppTextStyles.doneMessage,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'One question a day builds the habit.',
                  style: AppTextStyles.categoryLabel,
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.push(AppRoutes.problem),
                    child: Text(
                      "Today's Question",
                      style: AppTextStyles.buttonLabel,
                    ),
                  ),
                ),
              ],

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
