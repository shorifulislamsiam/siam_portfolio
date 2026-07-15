import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';

/// Animated social icon button with hover effects.
///
/// Usage:
/// ```dart
/// PortfolioSocialButton(icon: Icons.email, onTap: () {}, tooltip: 'Email')
/// ```
class PortfolioSocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color? color;
  final double size;

  const PortfolioSocialButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.color,
    this.size = AppDimensions.iconMd,
  });

  @override
  State<PortfolioSocialButton> createState() => _PortfolioSocialButtonState();
}

class _PortfolioSocialButtonState extends State<PortfolioSocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF818CF8);
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered
                  ? accent.withAlpha(40)
                  : Colors.transparent,
              border: Border.all(
                color: _hovered
                    ? accent
                    : (widget.color ?? accent).withAlpha(80),
                width: 1.5,
              ),
            ),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: _hovered ? accent : (widget.color ?? accent).withAlpha(180),
            ),
          ),
        ),
      ),
    );
  }
}
