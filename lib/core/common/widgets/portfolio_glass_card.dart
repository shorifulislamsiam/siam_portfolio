import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';

/// Glassmorphism card widget.
///
/// Usage:
/// ```dart
/// PortfolioGlassCard(child: Text('Hello'))
/// ```
class PortfolioGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double blur;
  final double opacity;
  final Color? borderColor;
  final Color? backgroundColor;

  const PortfolioGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blur = 10,
    this.opacity = 0.08,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = isDark
        ? const Color(0xFF1E1F3A).withAlpha((opacity * 255).toInt())
        : Colors.white.withAlpha((opacity * 8 * 255).toInt());

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.cardRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
          decoration: BoxDecoration(
            color: backgroundColor ?? defaultBg,
            borderRadius: borderRadius ??
                BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(
              color: borderColor ??
                  (isDark
                      ? const Color(0xFF818CF8).withAlpha(40)
                      : Colors.white.withAlpha(180)),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
