import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'streak_provider.dart';
import 'streak_repository.dart';

// ─── Public entry-point ───────────────────────────────────────────────────────

/// Displays the user's current streak count with loading and error states.
///
/// Observes [streakNotifierProvider] and delegates rendering to private
/// sub-widgets. No business logic lives inside `build()`.
///
/// Usage:
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
        message: error.toString(),
        onRetry: () => ref.invalidate(streakNotifierProvider),
      ),
    );
  }
}

// ─── Data state ───────────────────────────────────────────────────────────────

class _StreakContent extends StatelessWidget {
  const _StreakContent({required this.data});

  final StreakData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Header row ────────────────────────────────────────────────────
          Row(
            children: [
              const _FlameIcon(),
              const SizedBox(width: 8),
              Text(
                'STREAK',
                style: textTheme.labelSmall?.copyWith(
                  letterSpacing: 1.5,
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Current streak count ──────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${data.currentStreak}',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                  height: 1,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                data.currentStreak == 1 ? 'day' : 'days',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ── Best streak ───────────────────────────────────────────────────
          Text(
            'Best: ${data.bestStreak} ${data.bestStreak == 1 ? 'day' : 'days'}',
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),

          // ── Active indicator ──────────────────────────────────────────────
          if (data.currentStreak > 0) ...[
            const SizedBox(height: 12),
            _StreakBar(
              currentStreak: data.currentStreak,
              bestStreak: data.bestStreak,
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Progress bar ─────────────────────────────────────────────────────────────

class _StreakBar extends StatelessWidget {
  const _StreakBar({
    required this.currentStreak,
    required this.bestStreak,
  });

  final int currentStreak;
  final int bestStreak;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fraction = bestStreak > 0
        ? (currentStreak / bestStreak).clamp(0.0, 1.0)
        : 1.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: 3,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              height: 3,
              width: constraints.maxWidth * fraction,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ─── Loading state ────────────────────────────────────────────────────────────

class _StreakLoading extends StatelessWidget {
  const _StreakLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _Shimmer(width: 60, height: 12, borderRadius: 4),
          const SizedBox(height: 14),
          _Shimmer(width: 100, height: 36, borderRadius: 6),
          const SizedBox(height: 10),
          _Shimmer(width: 80, height: 10, borderRadius: 4),
          const SizedBox(height: 12),
          _Shimmer(width: double.infinity, height: 3, borderRadius: 2),
        ],
      ),
    );
  }
}

/// Minimal skeleton shimmer using an animated opacity pulse.
class _Shimmer extends StatefulWidget {
  const _Shimmer({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _opacity = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return FadeTransition(
      opacity: _opacity,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

// ─── Error state ──────────────────────────────────────────────────────────────

class _StreakError extends StatelessWidget {
  const _StreakError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer,
        border: Border.all(color: colorScheme.error.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: colorScheme.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Could not load streak.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'RETRY',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared sub-widgets ───────────────────────────────────────────────────────

class _FlameIcon extends StatelessWidget {
  const _FlameIcon();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.local_fire_department_rounded,
      size: 18,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
