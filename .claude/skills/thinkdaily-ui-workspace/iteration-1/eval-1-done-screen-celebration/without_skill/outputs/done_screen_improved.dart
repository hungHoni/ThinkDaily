import 'dart:math' as math;

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
// DoneScreen — celebratory completion screen
// ---------------------------------------------------------------------------

class DoneScreen extends ConsumerStatefulWidget {
  const DoneScreen({super.key});

  @override
  ConsumerState<DoneScreen> createState() => _DoneScreenState();
}

class _DoneScreenState extends ConsumerState<DoneScreen>
    with TickerProviderStateMixin {
  late final AnimationController _particleController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final streakAsync = ref.watch(streakServiceProvider);
    final xpAsync = ref.watch(xpServiceProvider);

    final streak = streakAsync.valueOrNull?.count ?? 0;
    final xp = xpAsync.valueOrNull?.total ?? 0;
    final noAnim = MediaQuery.of(context).disableAnimations;
    final isMilestone = streak > 0 && streak % 7 == 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Particle burst layer — behind content
          if (!noAnim)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _particleController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _ConfettiPainter(
                      progress: _particleController.value,
                    ),
                  );
                },
              ),
            ),

          // Main content
          SafeArea(
            child: Padding(
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  // Check mark icon with scale-in pop
                  _CheckmarkBadge(noAnim: noAnim, pulseController: _pulseController),

                  const SizedBox(height: AppSpacing.lg),

                  // Headline
                  _HeadlineText(noAnim: noAnim),

                  const SizedBox(height: AppSpacing.xs),

                  // Sub-headline
                  _SubText(noAnim: noAnim),

                  const SizedBox(height: AppSpacing.xxl),

                  // Divider
                  _AnimatedDivider(noAnim: noAnim),

                  const SizedBox(height: AppSpacing.xxl),

                  // Stat cards row
                  _StatCards(
                    streak: streak,
                    xp: xp,
                    noAnim: noAnim,
                  ),

                  // Milestone banner
                  if (isMilestone) ...[
                    const SizedBox(height: AppSpacing.lg),
                    _MilestoneBanner(streak: streak, noAnim: noAnim),
                  ],

                  const Spacer(flex: 2),

                  // CTA Button
                  _DoneButton(noAnim: noAnim),

                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Checkmark badge with pulse ring
// ---------------------------------------------------------------------------

class _CheckmarkBadge extends StatelessWidget {
  const _CheckmarkBadge({
    required this.noAnim,
    required this.pulseController,
  });

  final bool noAnim;
  final AnimationController pulseController;

  @override
  Widget build(BuildContext context) {
    final badge = Stack(
      alignment: Alignment.center,
      children: [
        // Pulse ring
        if (!noAnim)
          AnimatedBuilder(
            animation: pulseController,
            builder: (context, _) {
              final scale = 1.0 + pulseController.value * 0.12;
              final opacity = 1.0 - pulseController.value * 0.5;
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.text.withOpacity(opacity * 0.25),
                      width: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),

        // Solid circle + check
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.invertedBackground,
          ),
          child: const Icon(
            Icons.check,
            color: AppColors.invertedText,
            size: 26,
          ),
        ),
      ],
    );

    if (noAnim) return badge;

    return badge
        .animate()
        .scale(
          begin: const Offset(0.4, 0.4),
          end: const Offset(1.0, 1.0),
          duration: 500.ms,
          curve: Curves.elasticOut,
          delay: 100.ms,
        )
        .fadeIn(duration: 200.ms, delay: 100.ms);
  }
}

// ---------------------------------------------------------------------------
// Headline + sub-headline
// ---------------------------------------------------------------------------

class _HeadlineText extends StatelessWidget {
  const _HeadlineText({required this.noAnim});
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final text = Text('Nicely done.', style: AppTextStyles.doneMessage);

    if (noAnim) return text;

    return text
        .animate(delay: 400.ms)
        .fadeIn(duration: 500.ms)
        .moveY(begin: 10, end: 0, duration: 500.ms, curve: Curves.easeOut);
  }
}

class _SubText extends StatelessWidget {
  const _SubText({required this.noAnim});
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      'You showed up today.',
      style: AppTextStyles.feedbackResult,
    );

    if (noAnim) return text;

    return text
        .animate(delay: 550.ms)
        .fadeIn(duration: 500.ms)
        .moveY(begin: 8, end: 0, duration: 500.ms, curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// Thin animated divider
// ---------------------------------------------------------------------------

class _AnimatedDivider extends StatelessWidget {
  const _AnimatedDivider({required this.noAnim});
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final divider = Container(
      height: 1,
      color: AppColors.border,
    );

    if (noAnim) return divider;

    return divider
        .animate(delay: 650.ms)
        .scaleX(
          begin: 0,
          end: 1,
          duration: 600.ms,
          curve: Curves.easeOut,
          alignment: Alignment.centerLeft,
        )
        .fadeIn(duration: 300.ms, delay: 650.ms);
  }
}

// ---------------------------------------------------------------------------
// Stat cards — two side-by-side panels with animated counters
// ---------------------------------------------------------------------------

class _StatCards extends StatelessWidget {
  const _StatCards({
    required this.streak,
    required this.xp,
    required this.noAnim,
  });

  final int streak;
  final int xp;
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'DAY STREAK',
            value: streak,
            icon: Icons.local_fire_department_outlined,
            delay: 750.ms,
            noAnim: noAnim,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            label: 'XP TOTAL',
            value: xp,
            icon: Icons.bolt_outlined,
            delay: 900.ms,
            noAnim: noAnim,
          ),
        ),
      ],
    );

    return row;
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.delay,
    required this.noAnim,
  });

  final String label;
  final int value;
  final IconData icon;
  final Duration delay;
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(height: AppSpacing.sm),
          _AnimatedCounter(value: value, noAnim: noAnim, delay: delay),
          const SizedBox(height: AppSpacing.xs),
          Text(label, style: AppTextStyles.categoryLabel),
        ],
      ),
    );

    if (noAnim) return card;

    return card
        .animate(delay: delay)
        .fadeIn(duration: 400.ms)
        .moveY(begin: 12, end: 0, duration: 400.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.96, 0.96),
          end: const Offset(1.0, 1.0),
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }
}

// ---------------------------------------------------------------------------
// Animated counter — counts up from 0 to target
// ---------------------------------------------------------------------------

class _AnimatedCounter extends StatelessWidget {
  const _AnimatedCounter({
    required this.value,
    required this.noAnim,
    required this.delay,
  });

  final int value;
  final bool noAnim;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    if (noAnim) {
      return Text('$value', style: AppTextStyles.appTitle);
    }

    // Delay the counter start to match card entrance
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: delay + 1000.ms,
      curve: Curves.easeOut,
      builder: (context, progress, _) {
        // Only start counting after the delay fraction has elapsed
        final delayFraction = delay.inMilliseconds /
            (delay.inMilliseconds + 1000);
        final countProgress =
            progress < delayFraction ? 0.0 : (progress - delayFraction) / (1 - delayFraction);
        final animatedValue = (value * countProgress).round();

        return Text('$animatedValue', style: AppTextStyles.appTitle);
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Milestone banner
// ---------------------------------------------------------------------------

class _MilestoneBanner extends StatelessWidget {
  const _MilestoneBanner({required this.streak, required this.noAnim});

  final int streak;
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final banner = Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.invertedBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.workspace_premium_outlined,
            size: 14,
            color: AppColors.invertedText,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '$streak DAY MILESTONE',
            style: AppTextStyles.categoryLabel.copyWith(
              color: AppColors.invertedText,
            ),
          ),
        ],
      ),
    );

    if (noAnim) return banner;

    return banner
        .animate(delay: 1050.ms)
        .fadeIn(duration: 500.ms)
        .moveY(begin: 6, end: 0, duration: 500.ms, curve: Curves.easeOut)
        .shimmer(
          duration: 1200.ms,
          delay: 1200.ms,
          color: Colors.white.withOpacity(0.08),
        );
  }
}

// ---------------------------------------------------------------------------
// CTA button
// ---------------------------------------------------------------------------

class _DoneButton extends StatelessWidget {
  const _DoneButton({required this.noAnim});
  final bool noAnim;

  @override
  Widget build(BuildContext context) {
    final button = SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () => context.go(AppRoutes.home),
        child: Text('Back to Home', style: AppTextStyles.buttonLabel),
      ),
    );

    if (noAnim) return button;

    return button
        .animate(delay: 1100.ms)
        .fadeIn(duration: 400.ms)
        .moveY(begin: 8, end: 0, duration: 400.ms, curve: Curves.easeOut);
  }
}

// ---------------------------------------------------------------------------
// Confetti / particle burst painter
// ---------------------------------------------------------------------------

class _Particle {
  _Particle({
    required this.origin,
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotationSpeed,
  });

  final Offset origin;
  final double angle;
  final double speed;
  final double size;
  final Color color;
  final double rotationSpeed;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter({required this.progress});

  final double progress;

  static final List<_Particle> _particles = _buildParticles();

  static List<_Particle> _buildParticles() {
    final rand = math.Random(42); // fixed seed for deterministic layout
    const colors = [
      Color(0xFF111111),
      Color(0xFF555555),
      Color(0xFFBBBBBB),
      Color(0xFFE0E0E0),
    ];

    return List.generate(28, (i) {
      final angle = rand.nextDouble() * math.pi * 2;
      return _Particle(
        origin: const Offset(0.5, 0.35), // normalized — resolved per frame
        angle: angle,
        speed: 0.18 + rand.nextDouble() * 0.22,
        size: 4.0 + rand.nextDouble() * 5.0,
        color: colors[rand.nextInt(colors.length)],
        rotationSpeed: (rand.nextDouble() - 0.5) * 6,
      );
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Only paint during the burst window (first ~70% of animation)
    if (progress == 0 || progress > 0.85) return;

    // Ease-in-out for the spread
    final t = Curves.easeOut.transform((progress / 0.7).clamp(0, 1));
    // Fade out in last 30% of burst window
    final opacity = progress < 0.55
        ? 1.0
        : (1.0 - ((progress - 0.55) / 0.30).clamp(0, 1));

    final origin = Offset(size.width * 0.5, size.height * 0.28);

    for (final p in _particles) {
      final dx = math.cos(p.angle) * p.speed * size.width * t;
      // Gravity: extra downward bias proportional to t²
      final dy = math.sin(p.angle) * p.speed * size.height * t +
          0.18 * size.height * t * t;

      final pos = origin + Offset(dx, dy);
      final rotation = p.rotationSpeed * t;

      final paint = Paint()
        ..color = p.color.withOpacity(opacity)
        ..isAntiAlias = true;

      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      canvas.rotate(rotation);

      // Alternate between squares and thin rectangles for variety
      final isRect = _particles.indexOf(p).isEven;
      if (isRect) {
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.45,
          ),
          paint,
        );
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset.zero,
              width: p.size * 0.7,
              height: p.size * 0.7,
            ),
            const Radius.circular(2),
          ),
          paint,
        );
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
