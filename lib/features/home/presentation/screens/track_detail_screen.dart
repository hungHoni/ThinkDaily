import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/home/presentation/providers/home_providers.dart';
import 'package:think_daily/features/problem/data/models/track.dart';
import 'package:think_daily/features/problem/data/sources/user_progress_service.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';

class TrackDetailScreen extends ConsumerWidget {
  const TrackDetailScreen({required this.trackId, super.key});

  final String trackId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(userProgressServiceProvider);
    final activeTrackId = ref.watch(activeTrackNotifierProvider);
    final source = ref.watch(problemLocalSourceProvider);

    if (progressAsync.isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: SizedBox.shrink(),
      );
    }

    final progressSvc = progressAsync.value!;
    final allTracks = source.getAllTracks();
    final track = allTracks.firstWhere((t) => t.id == trackId);
    final units = source.getUnitsForTrack(trackId);
    final progress = progressSvc.getProgress(trackId);
    final completedUnits = progress.currentUnitIndex;
    final trackDone = completedUnits >= track.totalUnits;
    final isActive = trackId == activeTrackId;
    final completedToday = progressSvc.hasCompletedToday(trackId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
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
                      const Spacer(),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Track identity ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title.toUpperCase(),
                        style: AppTextStyles.sectionLabel.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        track.description,
                        style: AppTextStyles.trackTitle.copyWith(
                          color: AppColors.text,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Progress summary
                      Row(
                        children: [
                          Text(
                            trackDone
                                ? 'Complete'
                                : '$completedUnits of ${track.totalUnits} units done',
                            style: AppTextStyles.sectionLabel,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.border),

                // ── Unit list ────────────────────────────────────────────
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: units.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, i) {
                      final unit = units[i];
                      final isCompleted = i < completedUnits;
                      final isCurrent = i == completedUnits && !trackDone;
                      return _UnitRow(
                        unit: unit,
                        isCompleted: isCompleted,
                        isCurrent: isCurrent,
                      );
                    },
                  ),
                ),

                const Divider(height: 1, color: AppColors.border),

                // ── CTA ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: isActive
                        ? _ActiveTrackCta(
                            completedToday: completedToday,
                            trackDone: trackDone,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              ref
                                  .read(activeTrackNotifierProvider.notifier)
                                  .setTrack(trackId);
                              context.go(AppRoutes.home);
                            },
                            child: Text(
                              'Start this track',
                              style: AppTextStyles.buttonLabel,
                            ),
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

class _ActiveTrackCta extends StatelessWidget {
  const _ActiveTrackCta({
    required this.completedToday,
    required this.trackDone,
  });

  final bool completedToday;
  final bool trackDone;

  @override
  Widget build(BuildContext context) {
    if (trackDone) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Track complete.', style: AppTextStyles.doneMessage),
            const SizedBox(height: 2),
            Text(
              'Choose another track to continue.',
              style: AppTextStyles.categoryLabel,
            ),
          ],
        ),
      );
    }

    if (completedToday) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Done for today.', style: AppTextStyles.doneMessage),
            const SizedBox(height: 2),
            Text(
              'One question a day builds the habit.',
              style: AppTextStyles.categoryLabel,
            ),
          ],
        ),
      );
    }

    return ElevatedButton(
      onPressed: () {
        HapticFeedback.mediumImpact();
        context.push(AppRoutes.problem);
      },
      child: Text("Begin today's question", style: AppTextStyles.buttonLabel),
    );
  }
}

// ── Unit row ─────────────────────────────────────────────────────────────────

class _UnitRow extends StatelessWidget {
  const _UnitRow({
    required this.unit,
    required this.isCompleted,
    required this.isCurrent,
  });

  final Unit unit;
  final bool isCompleted;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final numberColor =
        isCompleted || isCurrent ? AppColors.textSecondary : AppColors.border;

    final titleStyle = isCurrent
        ? AppTextStyles.trackTitle
        : AppTextStyles.trackTitle.copyWith(
            color: isCompleted ? AppColors.textSecondary : AppColors.border,
            fontWeight: FontWeight.w400,
          );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.md,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '0${unit.index + 1}',
              style: AppTextStyles.sectionLabel.copyWith(color: numberColor),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(unit.title, style: titleStyle),
                if (isCurrent) ...[
                  const SizedBox(height: 5),
                  Text(
                    unit.subtitle,
                    style: AppTextStyles.sectionLabel.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 20,
            child: Text(
              isCompleted ? '✓' : (isCurrent ? '→' : ''),
              style: AppTextStyles.sectionLabel.copyWith(
                color: isCompleted ? AppColors.textSecondary : AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
