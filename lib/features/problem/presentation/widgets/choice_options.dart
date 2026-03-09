import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';

class ChoiceOptions extends StatelessWidget {
  const ChoiceOptions({
    required this.options,
    required this.selectedIndex,
    required this.onSelect,
    this.disabled = false,
    super.key,
  });

  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < options.length; i++) ...[
          _OptionTile(
            label: options[i],
            isSelected: selectedIndex == i,
            onTap: disabled ? null : () => onSelect(i),
          ),
          if (i < options.length - 1)
            const Divider(height: 1, color: AppColors.border),
        ],
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      color: isSelected ? AppColors.invertedBackground : AppColors.background,
      child: InkWell(
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: isSelected
                      ? AppTextStyles.optionTextInverted
                      : AppTextStyles.optionText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
