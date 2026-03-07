import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';
import 'package:think_daily/features/problem/data/models/problem.dart';

class DoneScreen extends ConsumerWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tomorrow = _tomorrowCategory();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('Come back tomorrow.', style: AppTextStyles.doneMessage),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Tomorrow: ${tomorrow.label}',
                style: AppTextStyles.categoryLabel,
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  ProblemCategory _tomorrowCategory() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final dayIndex = (tomorrow.weekday - 1) % 7;
    return ProblemCategoryX.fromDayOfWeek(dayIndex);
  }
}
