import 'package:flutter/material.dart';

/// Centralized theme-aware color helpers.
/// Use these instead of hardcoding dark-mode colors.
class AppThemeColors {
  AppThemeColors._();

  // Dark mode accents (indigo/violet)
  static const Color darkPrimary   = Color(0xFF818CF8);
  static const Color darkSecondary = Color(0xFFA78BFA);
  static const Color darkBg        = Color(0xFF090818);
  static const Color darkCard      = Color(0xFF1E1F3A);
  static const Color darkAlt       = Color(0xFF0A0A1A);
  static const Color darkFooter    = Color(0xFF040B18);

  // Light mode accents (sky / ocean blue)
  static const Color lightPrimary   = Color(0xFF0EA5E9);
  static const Color lightSecondary = Color(0xFF38BDF8);
  static const Color lightBg        = Color(0xFFFFFFFF);
  static const Color lightCard      = Color(0xFFF0F9FF); // sky-50
  static const Color lightAlt       = Color(0xFFE0F2FE); // sky-100
  static const Color lightFooter    = Color(0xFFF8FAFC);

  /// Primary accent (indigo dark / sky light)
  static Color primary(BuildContext context) =>
      _isDark(context) ? darkPrimary : lightPrimary;

  /// Secondary accent (violet dark / sky-light)
  static Color secondary(BuildContext context) =>
      _isDark(context) ? darkSecondary : lightSecondary;

  /// Card / container background
  static Color cardBg(BuildContext context) =>
      _isDark(context) ? darkCard : lightCard;

  /// Alternate section background
  static Color altBg(BuildContext context) =>
      _isDark(context) ? darkAlt : lightAlt;

  /// Footer background
  static Color footerBg(BuildContext context) =>
      _isDark(context) ? darkFooter : lightFooter;

  /// Main text color
  static Color textMain(BuildContext context) =>
      _isDark(context) ? Colors.white : const Color(0xFF0C4A6E);

  /// Subtle text color
  static Color textSubtle(BuildContext context) =>
      _isDark(context)
          ? Colors.white.withAlpha(160)
          : const Color(0xFF334155); // slate-700

  /// Very subtle / hint text
  static Color textHint(BuildContext context) =>
      _isDark(context)
          ? Colors.white.withAlpha(100)
          : const Color(0xFF64748B); // slate-500

  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
