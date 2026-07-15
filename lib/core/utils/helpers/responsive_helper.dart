import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';

/// Helper class for responsive layout decisions.
/// Usage: ResponsiveHelper.isMobile(context)
class ResponsiveHelper {
  ResponsiveHelper._();

  /// Returns true if screen width < 600
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppDimensions.mobileBreakpoint;

  /// Returns true if screen width is between 600 and 900
  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppDimensions.mobileBreakpoint &&
        w < AppDimensions.tabletBreakpoint;
  }

  /// Returns true if screen width is between 900 and 1200
  static bool isLaptop(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppDimensions.tabletBreakpoint &&
        w < AppDimensions.desktopBreakpoint;
  }

  /// Returns true if screen width >= 1200
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.desktopBreakpoint;

  /// Returns true if screen width >= 1600
  static bool isUltraWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.ultraWideBreakpoint;

  /// Returns true for desktop or larger
  static bool isDesktopOrLarger(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.desktopBreakpoint;

  /// Returns true for tablet or larger
  static bool isTabletOrLarger(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.mobileBreakpoint;

  /// Horizontal section padding based on screen width
  static double sectionHPadding(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= AppDimensions.desktopBreakpoint) {
      return AppDimensions.sectionPaddingHDesktop;
    } else if (w >= AppDimensions.mobileBreakpoint) {
      return AppDimensions.sectionPaddingHTablet;
    }
    return AppDimensions.sectionPaddingH;
  }

  /// Returns the number of grid columns based on screen width.
  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) {
    if (isDesktop(context)) return desktop;
    if (isTabletOrLarger(context)) return tablet;
    return mobile;
  }

  /// Responsive value selector — picks the best value for current screen.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) return desktop;
    if (isTabletOrLarger(context) && tablet != null) return tablet;
    return mobile;
  }
}
