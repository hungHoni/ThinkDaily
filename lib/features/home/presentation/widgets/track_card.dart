import 'package:flutter/material.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/problem/data/models/track.dart';

/// A track row in the HomeScreen browser.
///
/// [isActive] tracks are shown with full description and a darker progress
/// bar. Inactive tracks are shown compactly in muted type.
class TrackCard extends StatelessWidget {
  const TrackCard({
    required this.track,
    required this.completedUnits,
    required this.isActive,
    required this.onTap,
    super.key,
  });

  final Track track;
  final int completedUnits;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDone = completedUnits >= track.totalUnits;
    final fraction =
        track.totalUnits > 0 ? completedUnits / track.totalUnits : 0.0;

    final titleStyle = isActive
        ? AppTextStyles.trackTitle
        : AppTextStyles.trackTitle.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.lg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(track.title, style: titleStyle),

                  // Description — only for active track
                  if (isActive) ...[
                    const SizedBox(height: 6),
                    Text(
                      track.description,
                      style: AppTextStyles.sectionLabel.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 0.4,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Progress bar
                  LayoutBuilder(
                    builder: (context, constraints) => Stack(
                      children: [
                        Container(
                          height: 2,
                          width: constraints.maxWidth,
                          color: AppColors.border,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOut,
                          height: 2,
                          width: constraints.maxWidth * fraction,
                          color: isActive
                              ? AppColors.text
                              : AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Unit count
                  Text(
                    isDone
                        ? 'Complete'
                        : '$completedUnits of ${track.totalUnits} units',
                    style: AppTextStyles.categoryLabel.copyWith(
                      color: isActive
                          ? AppColors.textSecondary
                          : AppColors.border,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Arrow — always visible, dimmer for inactive
            Text(
              '→',
              style: AppTextStyles.trackTitle.copyWith(
                color: isActive ? AppColors.text : AppColors.border,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
