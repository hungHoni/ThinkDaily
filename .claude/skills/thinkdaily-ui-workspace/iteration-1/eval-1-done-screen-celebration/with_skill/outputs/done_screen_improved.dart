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

// ---------------------------------------------------------------------------
// DoneScreen
//
// Celebratory end-of-session screen. Design philosophy:
//   - Editorial minimal — no confetti, no color accents.
//   - Staggered entry: headline → subline → divider → stats → button.
//   - Stats count up from 0, but only AFTER their row has become visible,
//     so the animation feels earned rather than premature.
//   - Reduced-motion: all animations skip when MediaQuery.disableAnimations
//     is true; count-up jumps straight to final value.
// ---------------------------------------------------------------------------

class DoneScreen extends ConsumerWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync = ref.watch(streakServiceProvider);
    final xpAsync = ref.watch(xpServiceProvider);

    final streak = streakAsync.valueOrNull?.count ?? 0;
    final xp = xpAsync.valueOrNull?.total ?? 0;
    final noAnim = MediaQuery.of(context).disableAnimations;

    // Timing ladder (ms from screen mount):
    //   0    — headline fades in
    //   300  — subline fades in
    //   500  — thin divider draws in
    //   650  — streak row appears; count-up starts at 700 (50 ms after visible)
    //   850  — XP row appears; count-up starts at 900
    //   1050 — milestone note (conditional)
    //   1100 — button slides up
    //
    // When noAnim=true, every child renders statically with no wrapper.

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              // ── Headline ──────────────────────────────────────────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: Duration.zero,
                child: Text('Nicely done.', style: AppTextStyles.doneMessage),
              ),

              const SizedBox(height: AppSpacing.sm),

              // ── Sub-headline (adds emotional depth without being loud) ───
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'You showed up.',
                  style: AppTextStyles.doneMessage.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Thin ruled divider — editorial section break ─────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 500),
                slideY: false, // divider grows in place, no vertical shift
                child: const Divider(height: 1, color: AppColors.border),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Streak stat ───────────────────────────────────────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 650),
                child: _StatRow(
                  label: 'DAY STREAK',
                  value: streak,
                  // Count-up starts 50 ms after the row becomes visible.
                  countDelay: noAnim
                      ? Duration.zero
                      : const Duration(milliseconds: 700),
                  noAnim: noAnim,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Thin separator between stats ─────────────────────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 750),
                slideY: false,
                child: const Divider(height: 1, color: AppColors.border),
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── XP stat ───────────────────────────────────────────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 850),
                child: _StatRow(
                  label: 'XP TOTAL',
                  value: xp,
                  countDelay: noAnim
                      ? Duration.zero
                      : const Duration(milliseconds: 900),
                  noAnim: noAnim,
                ),
              ),

              // ── Streak milestone callout (every 7 days) ──────────────────
              if (streak > 0 && streak % 7 == 0) ...[
                const SizedBox(height: AppSpacing.md),
                _maybeAnimate(
                  noAnim: noAnim,
                  delay: const Duration(milliseconds: 1050),
                  slideY: false,
                  child: Text(
                    '$streak day milestone.',
                    style: AppTextStyles.categoryLabel,
                  ),
                ),
              ],

              const Spacer(flex: 2),

              // ── CTA ───────────────────────────────────────────────────────
              _maybeAnimate(
                noAnim: noAnim,
                delay: const Duration(milliseconds: 1100),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    child: Text('Back to Home', style: AppTextStyles.buttonLabel),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  /// Wraps [child] in a staggered fade + slide-up animation.
  ///
  /// When [noAnim] is true or [slideY] is false, the vertical shift is
  /// omitted so the widget enters purely via opacity or not at all.
  Widget _maybeAnimate({
    required bool noAnim,
    required Duration delay,
    required Widget child,
    bool slideY = true,
  }) {
    if (noAnim) return child;

    var animated = child
        .animate(delay: delay)
        .fadeIn(duration: 450.ms, curve: Curves.easeOut);

    if (slideY) {
      animated = animated.moveY(
        begin: 10,
        end: 0,
        duration: 450.ms,
        curve: Curves.easeOut,
      );
    }

    return animated;
  }
}

// ---------------------------------------------------------------------------
// _StatRow
//
// Displays a single stat — large Lora number + mono label.
//
// The count-up animation is driven by a TweenAnimationBuilder whose start
// is deferred via [countDelay]. Without the delay, the counter would be
// mid-animation while the row is still invisible during its fade-in, making
// the count-up feel wasted. By aligning [countDelay] to fire just after the
// row's fade-in delay, the number starts at 0 exactly when the user can
// first see it.
//
// A subtle scale pulse at the end of the count-up — using flutter_animate —
// adds a satisfying "lock-in" moment without being garish.
// ---------------------------------------------------------------------------

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    required this.value,
    required this.countDelay,
    required this.noAnim,
  });

  final String label;
  final int value;

  /// When this duration has elapsed after widget mount, the counter begins
  /// animating from 0 to [value].
  final Duration countDelay;

  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        _AnimatedCounter(
          target: value,
          delay: countDelay,
          noAnim: noAnim,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTextStyles.categoryLabel),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _AnimatedCounter
//
// StatefulWidget so it can own the TweenAnimationBuilder trigger correctly.
// Using a StatefulWidget (rather than a plain builder in a StatelessWidget)
// ensures the Future.delayed approach is stable across rebuilds.
//
// Animation curve: easeOutCubic — fast start, decelerates toward the final
// value, giving a "settling" feel rather than a mechanical linear count.
//
// The lock-in pulse: a brief scale 1.0 → 1.06 → 1.0 fires once the counter
// reaches its target. This is achieved by chaining an additional
// flutter_animate effect with an explicit delay matching the count duration.
// ---------------------------------------------------------------------------

class _AnimatedCounter extends StatefulWidget {
  const _AnimatedCounter({
    required this.target,
    required this.delay,
    required this.noAnim,
  });

  final int target;
  final Duration delay;
  final bool noAnim;

  @override
  State<_AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<_AnimatedCounter> {
  // When true, the TweenAnimationBuilder animates from 0 → target.
  // When false, it shows [widget.target] instantly (noAnim mode or pre-delay).
  bool _counting = false;

  static const _countDuration = Duration(milliseconds: 900);
  static const _pulseDuration = Duration(milliseconds: 180);

  @override
  void initState() {
    super.initState();
    if (widget.noAnim || widget.target == 0) {
      // No animation — render final value immediately.
      _counting = true;
      return;
    }
    // Defer the count-up start until the row is visible.
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _counting = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Before the delay fires, or when noAnim=true, show 0 (pre-delay) or
    // the final value (noAnim). Either way no TweenAnimationBuilder ticking.
    if (!_counting) {
      return Text('0', style: AppTextStyles.appTitle);
    }

    if (widget.noAnim || widget.target == 0) {
      // Reduced motion or zero value — static display, no animation.
      return Text('${widget.target}', style: AppTextStyles.appTitle);
    }

    // Count-up with a lock-in pulse on completion.
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: widget.target),
      duration: _countDuration,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        final isComplete = animatedValue == widget.target;

        Widget numberText = Text(
          '$animatedValue',
          style: AppTextStyles.appTitle,
        );

        // Lock-in pulse fires once the counter has reached its target.
        // The delay ensures we don't play the pulse during the count.
        if (isComplete) {
          numberText = numberText
              .animate()
              .scaleXY(
                begin: 1.0,
                end: 1.06,
                duration: _pulseDuration,
                curve: Curves.easeOut,
              )
              .then()
              .scaleXY(
                begin: 1.06,
                end: 1.0,
                duration: _pulseDuration,
                curve: Curves.easeIn,
              );
        }

        return numberText;
      },
    );
  }
}
