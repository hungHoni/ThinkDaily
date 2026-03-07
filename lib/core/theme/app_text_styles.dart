import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:think_daily/core/theme/app_colors.dart';

abstract class AppTextStyles {
  // Serif — used for problem prompts and explanations
  static TextStyle problemPrompt = GoogleFonts.lora(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.6,
    letterSpacing: 0.1,
  );

  static TextStyle explanationBody = GoogleFonts.lora(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.7,
    letterSpacing: 0.1,
  );

  static TextStyle feedbackResult = GoogleFonts.lora(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static TextStyle appTitle = GoogleFonts.lora(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
    letterSpacing: 1.5,
  );

  // Mono — used for category labels, thinking pattern names
  static TextStyle categoryLabel = GoogleFonts.jetBrainsMono(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  );

  static TextStyle thinkingPattern = GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    letterSpacing: 0.5,
  );

  // UI elements
  static TextStyle optionText = GoogleFonts.lora(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );

  static TextStyle optionTextInverted = GoogleFonts.lora(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.invertedText,
    height: 1.5,
  );

  static TextStyle buttonLabel = GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.invertedText,
    letterSpacing: 1,
  );

  static TextStyle doneMessage = GoogleFonts.lora(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
    height: 1.5,
  );
}
