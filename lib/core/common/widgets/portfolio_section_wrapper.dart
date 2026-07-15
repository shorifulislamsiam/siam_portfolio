import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';

/// Wraps each portfolio section with consistent max-width, padding, and
/// responsive horizontal spacing.
///
/// Usage:
/// ```dart
/// PortfolioSectionWrapper(child: AboutSection())
/// ```
class PortfolioSectionWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const PortfolioSectionWrapper({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHPadding(context);

    return Container(
      color: backgroundColor,
      width: double.infinity,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: hPad,
            vertical: AppDimensions.sectionPaddingV,
          ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: child,
        ),
      ),
    );
  }
}
