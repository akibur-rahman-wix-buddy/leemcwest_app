import 'package:flutter/material.dart';

/// NumoniX App Theme — centralised colour tokens and typography.
class AppColors {
  static const Color bg = Color(0xFF0E0E12);
  static const Color surface = Color(0xFF16161D);
  static const Color card = Color(0xFF1A1A24);
  static const Color border = Color(0xFF2A2A38);

  static const Color accent = Color(0xFF6C5CE7);
  static const Color accentGlow = Color(0x40604CE7);
  static const Color accentSoft = Color(0x196C5CE7);

  static const Color textPrimary = Color(0xFFE8E6F0);
  static const Color textSecondary = Color(0xFF9590A8);
  static const Color textMuted = Color(0xFF5C5873);

  static const Color calloutBg = Color(0x0F6C5CE7);
  static const Color calloutBorder = Color(0x4D6C5CE7);
  static const Color calloutTitle = Color(0xFFC2785A);

  static const Color gridBg = Color(0xFF13131A);
  static const Color gridBorder = Color(0xFF252535);
  static const Color gridHeader = Color(0xFF1C1C28);

  // FNH function colours
  static const Color fnT = Color(0xFF5B9BF5);
  static const Color fnS = Color(0xFF4ADE80);
  static const Color fnD = Color(0xFFF87171);
  static const Color fnDsharp = Color(0xFFA78BFA);
  static const Color fnDb = Color(0xFFF472B6);
  static const Color fnNeutral = Color(0xFF9590A8);

  static const Color success = Color(0xFF4ADE80);
  static const Color error = Color(0xFFF87171);

  static const Color quizCard = Color(0xFF1E1E2A);
  static const Color quizBorder = Color(0xFF2F2F42);
  static const Color quizSelected = Color(0x266C5CE7);
}

/// Typography helpers using DM Sans, Source Serif 4, and DM Mono.
///
/// Fonts must be added to pubspec.yaml:
///   fonts:
///     - family: DM Sans
///       fonts: [asset paths]
///     - family: Source Serif 4
///       fonts: [asset paths]
///     - family: DM Mono
///       fonts: [asset paths]
class AppTypography {
  static const String fontDisplay = 'DM Sans';
  static const String fontBody = 'Source Serif 4';
  static const String fontMono = 'DM Mono';

  static TextStyle heading({
    double size = 18,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.textPrimary,
  }) =>
      TextStyle(fontFamily: fontDisplay, fontSize: size, fontWeight: weight, color: color);

  static TextStyle body({
    double size = 15.5,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.textSecondary,
    double height = 1.72,
  }) =>
      TextStyle(fontFamily: fontBody, fontSize: size, fontWeight: weight, color: color, height: height);

  static TextStyle mono({
    double size = 13,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.textPrimary,
  }) =>
      TextStyle(fontFamily: fontMono, fontSize: size, fontWeight: weight, color: color);

  static TextStyle label({
    double size = 13,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.textSecondary,
  }) =>
      TextStyle(fontFamily: fontDisplay, fontSize: size, fontWeight: weight, color: color);

  static TextStyle button({
    double size = 14,
    FontWeight weight = FontWeight.w600,
    Color color = Colors.white,
  }) =>
      TextStyle(fontFamily: fontDisplay, fontSize: size, fontWeight: weight, color: color);
}

/// Shared spacing / sizing constants.
class AppSpacing {
  static const double elementGap = 20.0;
  static const double pagePadding = 24.0;
  static const double cardRadius = 10.0;
  static const double buttonRadius = 10.0;
}
