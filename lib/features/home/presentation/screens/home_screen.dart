import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:think_daily/app/router.dart';
import 'package:think_daily/core/theme/app_colors.dart';
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
    final currentUnit =
        units.isNotEmpty && progress.currentUnitIndex < units.length
            ? units[progress.currentUnitIndex]
            : null;
    final completedUnits = progress.currentUnitIndex;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header ──────────────────────────────────────
                  Row(
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

                  const SizedBox(height: 36),

                  // ── Track label ──────────────────────────────────
                  Text(
                    track.title.toUpperCase(),
                    style: AppTextStyles.categoryLabel,
                  ),

                  const SizedBox(height: 12),

                  // ── Unit title ───────────────────────────────────
                  if (currentUnit != null)
                    Text(
                      currentUnit.title,
                      style: GoogleFonts.lora(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                        height: 1.25,
                        letterSpacing: 0.1,
                      ),
                    ),

                  const SizedBox(height: 28),

                  // ── Progress ─────────────────────────────────────
                  Row(
                    children: [
                      for (var i = 0; i < track.totalUnits; i++) ...[
                        if (i > 0) const SizedBox(width: 5),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: i < completedUnits
                                ? AppColors.text
                                : i == completedUnits
                                    ? AppColors.textSecondary
                                    : AppColors.border,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Unit ${completedUnits + 1} of ${track.totalUnits}',
                    style: AppTextStyles.categoryLabel,
                  ),

                  const Spacer(),

                  // ── Stats ────────────────────────────────────────
                  Row(
                    children: [
                      Text(
                        '${streakSvc.count}',
                        style: AppTextStyles.thinkingPattern,
                      ),
                      const SizedBox(width: 4),
                      Text('day streak', style: AppTextStyles.categoryLabel),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('·', style: AppTextStyles.categoryLabel),
                      ),
                      Text(
                        '${xpSvc.total}',
                        style: AppTextStyles.thinkingPattern,
                      ),
                      const SizedBox(width: 4),
                      Text('xp', style: AppTextStyles.categoryLabel),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── CTA ──────────────────────────────────────────
                  if (completedToday)
                    const _CompletedState()
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
          ),
        ),
      ),
    );
  }
}

class _CompletedState extends StatelessWidget {
  const _CompletedState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Done for today.', style: AppTextStyles.doneMessage),
        const SizedBox(height: 4),
        Text(
          'One question a day builds the habit.',
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}
