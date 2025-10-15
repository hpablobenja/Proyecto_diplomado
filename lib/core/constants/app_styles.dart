// lib/core/constants/app_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppStyles {
  // ===== TYPOGRAPHY =====

  // Font Family (Inter for modern, clean look like Skillshare)
  static const String fontFamily = 'Inter';

  // Text Styles with proper hierarchy
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.3,
  );

  static TextStyle get displaySmall => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle get headlineSmall => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.6,
  );

  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.6,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.6,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.6,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ===== THEMED TEXT STYLES =====

  static TextStyle displayLargeThemed(bool isDark) =>
      displayLarge.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle displayMediumThemed(bool isDark) =>
      displayMedium.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle displaySmallThemed(bool isDark) =>
      displaySmall.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle headlineLargeThemed(bool isDark) =>
      headlineLarge.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle headlineMediumThemed(bool isDark) =>
      headlineMedium.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle headlineSmallThemed(bool isDark) =>
      headlineSmall.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle titleLargeThemed(bool isDark) =>
      titleLarge.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle titleMediumThemed(bool isDark) =>
      titleMedium.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle titleSmallThemed(bool isDark) =>
      titleSmall.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle bodyLargeThemed(bool isDark) =>
      bodyLarge.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle bodyMediumThemed(bool isDark) =>
      bodyMedium.copyWith(color: AppColors.getTextPrimaryColor(isDark));

  static TextStyle bodySmallThemed(bool isDark) =>
      bodySmall.copyWith(color: AppColors.getTextSecondaryColor(isDark));

  static TextStyle labelLargeThemed(bool isDark) =>
      labelLarge.copyWith(color: AppColors.getTextSecondaryColor(isDark));

  static TextStyle labelMediumThemed(bool isDark) =>
      labelMedium.copyWith(color: AppColors.getTextSecondaryColor(isDark));

  static TextStyle labelSmallThemed(bool isDark) =>
      labelSmall.copyWith(color: AppColors.getTextMutedColor(isDark));

  // ===== SPECIAL STYLES =====

  // CTA Button Style (inspired by Skillshare)
  static TextStyle get ctaButton => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // Quote/Testimonial Style (italic)
  static TextStyle get quote => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    letterSpacing: 0.25,
    height: 1.6,
  );

  // Caption for metadata
  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.4,
  );

  // ===== LEGACY SUPPORT =====

  // Keep old style names for backward compatibility
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subhead1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ===== SPACING CONSTANTS =====

  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // ===== BORDER RADIUS =====

  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;

  // ===== SHADOWS =====

  static List<BoxShadow> get shadowS => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowM => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowL => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // ===== ANIMATION DURATIONS =====

  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ===== CURVES =====

  static const Curve curveFast = Curves.easeInOut;
  static const Curve curveNormal = Curves.easeOutCubic;
  static const Curve curveSlow = Curves.easeInOutCubic;
}
