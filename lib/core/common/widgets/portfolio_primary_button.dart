import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';

/// Primary CTA button with gradient background + hover scale animation.
///
/// Usage:
/// ```dart
/// PortfolioPrimaryButton(label: 'Hire Me', onTap: () {})
/// ```
class PortfolioPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final double? width;
  final bool isOutline;

  const PortfolioPrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.width,
    this.isOutline = false,
  });

  @override
  State<PortfolioPrimaryButton> createState() => _PortfolioPrimaryButtonState();
}

class _PortfolioPrimaryButtonState extends State<PortfolioPrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.width,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLg,
              vertical: AppDimensions.spacingMd,
            ),
            decoration: BoxDecoration(
              gradient: widget.isOutline
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
              border: widget.isOutline
                  ? Border.all(
                      color: const Color(0xFF818CF8),
                      width: 2,
                    )
                  : null,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              boxShadow: _hovered && !widget.isOutline
                  ? [
                      BoxShadow(
                        color: const Color(0xFF818CF8).withAlpha(80),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: AppDimensions.iconSm + 2,
                    color: widget.isOutline
                        ? const Color(0xFF818CF8)
                        : Colors.white,
                  ),
                  const SizedBox(width: AppDimensions.spacingSm),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.isOutline
                          ? const Color(0xFF818CF8)
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
