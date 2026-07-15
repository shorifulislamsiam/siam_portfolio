import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';

/// Reusable animated section title with gradient underline.
///
/// Usage:
/// ```dart
/// PortfolioSectionTitle(title: 'About Me', subtitle: 'Who I am')
/// ```
class PortfolioSectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final bool animate;

  const PortfolioSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget content = Column(
      crossAxisAlignment: alignment,
      children: [
        // Subtitle / label above
        if (subtitle != null) ...[
          Text(
            subtitle!.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 3,
              color: const Color(0xFF818CF8),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
        ],
        // Main title
        Text(
          title,
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            height: 1.2,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        // Gradient underline bar
        _GradientBar(alignment: alignment),
      ],
    );

    if (!animate) return content;

    return content
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOut);
  }
}

class _GradientBar extends StatelessWidget {
  final CrossAxisAlignment alignment;
  const _GradientBar({required this.alignment});

  @override
  Widget build(BuildContext context) {
    final bar = Container(
      width: 60,
      height: 4,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
    );

    if (alignment == CrossAxisAlignment.center) {
      return Center(child: bar);
    } else if (alignment == CrossAxisAlignment.end) {
      return Align(alignment: Alignment.centerRight, child: bar);
    }
    return bar;
  }
}
