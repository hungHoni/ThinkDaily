import 'package:flutter/material.dart';

import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    required this.onPressed,
    this.visible = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: visible ? onPressed : null,
            child: Text('Submit', style: AppTextStyles.buttonLabel),
          ),
        ),
      ),
    );
  }
}
