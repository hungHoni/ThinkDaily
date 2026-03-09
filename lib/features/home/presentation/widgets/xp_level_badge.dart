import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/home/data/models/xp_level.dart';

/// Displays the user's current XP level name, a progress bar toward the next
/// level, and the XP remaining. Animates the bar on mount.
class XpLevelBadge extends StatelessWidget {
  const XpLevelBadge({required this.xp, super.key});

  final int xp;

  @override
  Widget build(BuildContext context) {
    final level = XpLevel.forXp(xp);
    final fraction = level.progressFraction(xp);
    final xpToNext = level.xpToNext(xp);
    final noAnim = MediaQuery.of(context).disableAnimations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Level name + total XP ────────────────────────────────────────
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              level.name.toUpperCase(),
              style: AppTextStyles.trackTitle.copyWith(
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Text('$xp XP', style: AppTextStyles.categoryLabel),
          ],
        ),

        const SizedBox(height: 10),

        // ── Progress bar ─────────────────────────────────────────────────
        LayoutBuilder(
          builder: (context, constraints) {
            final fullWidth = constraints.maxWidth;
            final filledWidth = fullWidth * fraction;

            return Stack(
              children: [
                Container(height: 2, width: fullWidth, color: AppColors.border),
                if (noAnim)
                  Container(height: 2, width: filledWidth, color: AppColors.text)
                else
                  AnimatedContainer(
                    duration: 900.ms,
                    curve: Curves.easeOut,
                    height: 2,
                    width: filledWidth,
                    color: AppColors.text,
                  ),
              ],
            );
          },
        ),

        const SizedBox(height: 6),

        // ── Next level label ─────────────────────────────────────────────
        if (level.isFinalLevel)
          Text('Peak level reached.', style: AppTextStyles.categoryLabel)
        else
          Text(
            '+$xpToNext XP to ${level.next!.name}',
            style: AppTextStyles.categoryLabel,
          ),
      ],
    );
  }
}
