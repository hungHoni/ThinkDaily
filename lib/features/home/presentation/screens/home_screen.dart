import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/history/data/sources/streak_service.dart';
import 'package:think_daily/features/history/data/sources/xp_service.dart';
import 'package:think_daily/features/home/presentation/providers/home_providers.dart';
import 'package:think_daily/features/home/presentation/widgets/track_card.dart';
import 'package:think_daily/features/home/presentation/widgets/xp_level_badge.dart';
import 'package:think_daily/features/problem/data/sources/user_progress_service.dart';
import 'package:think_daily/features/problem/presentation/providers/problem_provider.dart';

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
    final activeTrackId = ref.watch(activeTrackNotifierProvider);

    final tracks = source.getAllTracks();
    final activeTrack = tracks.firstWhere((t) => t.id == activeTrackId);
    final activeProgress = progressSvc.getProgress(activeTrackId);
    final completedToday = progressSvc.hasCompletedToday(activeTrackId);
    final trackDone = activeProgress.currentUnitIndex >= activeTrack.totalUnits;

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
                      Text('ThinkDaily', style: AppTextStyles.appTitle),
                      const Spacer(),
                      IconButton(
                        onPressed: () => context.push(AppRoutes.stats),
                        icon: const Icon(
                          Icons.bar_chart_rounded,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── XP Level Badge ───────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                  ),
                  child: XpLevelBadge(xp: xpSvc.total),
                ),

                const SizedBox(height: 20),
                const Divider(height: 1, color: AppColors.border),

                // ── Track list ───────────────────────────────────────────
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: tracks.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, i) {
                      final track = tracks[i];
                      final progress = progressSvc.getProgress(track.id);
                      final isActive = track.id == activeTrackId;
                      return TrackCard(
                        track: track,
                        completedUnits: progress.currentUnitIndex,
                        isActive: isActive,
                        onTap: () =>
                            context.push('${AppRoutes.track}/${track.id}'),
                      );
                    },
                  ),
                ),

                const Divider(height: 1, color: AppColors.border),

                // ── Stats + CTA ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${streakSvc.count}',
                            style: AppTextStyles.trackTitle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'day streak',
                            style: AppTextStyles.sectionLabel,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      if (completedToday || trackDone)
                        _CompletedState(trackDone: trackDone)
                      else
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              context.push(AppRoutes.problem);
                            },
                            child: Text(
                              "Begin today's question",
                              style: AppTextStyles.buttonLabel,
                            ),
                          ),
                        ),
                    ],
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

class _CompletedState extends StatelessWidget {
  const _CompletedState({required this.trackDone});

  final bool trackDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trackDone ? 'Track complete.' : 'Done for today.',
          style: AppTextStyles.doneMessage,
        ),
        const SizedBox(height: 4),
        Text(
          trackDone
              ? 'Explore another track below.'
              : 'One question a day builds the habit.',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}
