import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/constants/colors.dart';
import 'package:siam_portfolio/core/utils/theme/custom_themes/text_theme.dart';

/// Main application theme configuration.
/// Light (clean white) and Dark (deep navy) themes.
class AppTheme {
  AppTheme._();

  // ── Portfolio accent colours ───────────────────────────────────────────────
  static const Color _primaryAccent = Color(0xFF818CF8); // indigo-400 (dark mode)
  static const Color _secondaryAccent = Color(0xFFA78BFA); // violet-400 (dark mode)

  // ── Light mode ocean/sky-blue accent ─────────────────────────────────────
  static const Color _lightPrimary = Color(0xFF0EA5E9);   // sky-500
  static const Color _lightSecondary = Color(0xFF38BDF8); // sky-400

  // ── Light Theme (white + ocean/sky-blue) ─────────────────────────────────
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _lightPrimary,
      brightness: Brightness.light,
    ).copyWith(
      primary: _lightPrimary,
      secondary: _lightSecondary,
      surface: Colors.white,
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFFF0F9FF), // sky-50
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFBAE6FD)), // sky-200
      ),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFFE0F2FE)), // sky-100
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0F9FF), // sky-50
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBAE6FD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFBAE6FD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _lightPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );

  // ── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryAccent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: _primaryAccent,
      secondary: _secondaryAccent,
      surface: AppColors.containerColor1A1A2E,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryAccent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.containerColor1A1A2E,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.borderColor818CF8.withAlpha(40)),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.borderColor3B4861.withAlpha(80),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.containerColor1E1F3A,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: AppColors.borderColor3B4861.withAlpha(80)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: AppColors.borderColor3B4861.withAlpha(80)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryAccent, width: 2),
      ),
      hintStyle: TextStyle(
        color: AppColors.textGreyColor919EAB.withAlpha(160),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
  );
}
