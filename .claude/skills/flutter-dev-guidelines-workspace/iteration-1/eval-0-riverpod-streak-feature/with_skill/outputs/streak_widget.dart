import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';

import 'streak_provider.dart';
import 'streak_repository.dart';

// ---------------------------------------------------------------------------
// StreakWidget — top-level entry point
// ---------------------------------------------------------------------------

/// Displays the user's current streak with loading and error states.
///
/// Subscribes to [streakNotifierProvider] and delegates rendering to
/// [_StreakContent], [_StreakLoading], and [_StreakError] respectively.
///
/// Example usage (on a home screen or stats card):
/// ```dart
/// const StreakWidget()
/// ```
class StreakWidget extends ConsumerWidget {
  const StreakWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakNotifierProvider);

    return streakAsync.when(
      data: (data) => _StreakContent(data: data),
      loading: () => const _StreakLoading(),
      error: (error, _) => _StreakError(
        message: _errorMessage(error),
        onRetry: () => ref.invalidate(streakNotifierProvider),
      ),
    );
  }

  /// Maps arbitrary exceptions to a user-facing message.
  String _errorMessage(Object error) {
    // When a real backend and AppException are wired up, pattern-match here.
    return 'Could not load streak. Tap to retry.';
  }
}

// ---------------------------------------------------------------------------
// _StreakContent — data state
// ---------------------------------------------------------------------------

/// Renders the streak card when data is available.
///
/// Kept under ~100 lines; further visual pieces are extracted as sub-widgets.
class _StreakContent extends StatelessWidget {
  const _StreakContent({required this.data});

  final StreakData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'STREAK',
            style: AppTextStyles.sectionLabel,
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _StreakCounter(
                label: 'current',
                count: data.currentStreak,
              ),
              const SizedBox(width: 32),
              _StreakCounter(
                label: 'best',
                count: data.bestStreak,
              ),
            ],
          ),
          if (data.lastActivityDate != null) ...[
            const SizedBox(height: 10),
            Text(
              'Last: ${data.lastActivityDate}',
              style: AppTextStyles.categoryLabel,
            ),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.04, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// _StreakCounter — single stat column (extracted to stay under 100 lines)
// ---------------------------------------------------------------------------

class _StreakCounter extends StatelessWidget {
  const _StreakCounter({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$count',
          style: AppTextStyles.appTitle.copyWith(
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: AppTextStyles.categoryLabel,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _StreakLoading — loading state
// ---------------------------------------------------------------------------

/// Skeleton placeholder shown while streak data is being fetched.
///
/// Uses a shimmer-style container to communicate "something is loading here"
/// without resorting to a full-screen spinner.
class _StreakLoading extends StatelessWidget {
  const _StreakLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _ShimmerBar(width: 56, height: 11),
          const SizedBox(height: 14),
          Row(
            children: [
              _ShimmerBar(width: 64, height: 36),
              const SizedBox(width: 32),
              _ShimmerBar(width: 64, height: 36),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single animated shimmer rectangle.
class _ShimmerBar extends StatelessWidget {
  const _ShimmerBar({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2),
      ),
    )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 1200.ms,
          color: AppColors.surface,
        );
  }
}

// ---------------------------------------------------------------------------
// _StreakError — error state
// ---------------------------------------------------------------------------

/// Displayed when [streakNotifierProvider] enters the error state.
///
/// Always provides an [onRetry] callback so the user can recover without
/// restarting the app.
class _StreakError extends StatelessWidget {
  const _StreakError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.refresh,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.categoryLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
