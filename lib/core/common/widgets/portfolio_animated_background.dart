import 'package:flutter/material.dart';
import 'package:siam_portfolio/core/utils/theme/app_theme_colors.dart';

/// Animated gradient mesh background used in the Hero section.
/// Uses multiple stacked radial gradients that slowly pulse.
class PortfolioAnimatedBackground extends StatefulWidget {
  final Widget child;
  const PortfolioAnimatedBackground({super.key, required this.child});

  @override
  State<PortfolioAnimatedBackground> createState() =>
      _PortfolioAnimatedBackgroundState();
}

class _PortfolioAnimatedBackgroundState
    extends State<PortfolioAnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary   = AppThemeColors.primary(context);
    final secondary = AppThemeColors.secondary(context);
    final bgColor   = isDark
        ? AppThemeColors.darkBg
        : AppThemeColors.lightBg;
    final accentBlue = isDark
        ? const Color(0xFF56BEFF)
        : const Color(0xFF7DD3FC); // sky-300

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Stack(
          fit: StackFit.loose,
          children: [
            // Base background
            Positioned.fill(
              child: Container(color: bgColor),
            ),

            // Top-left orb
            Positioned(
              top: -100 + (_animation.value * 40),
              left: -100 + (_animation.value * 20),
              child: _Orb(
                size: 500,
                color: primary.withAlpha(isDark ? 30 : 40),
              ),
            ),

            // Bottom-right orb
            Positioned(
              bottom: -120 + (_animation.value * -30),
              right: -80 + (_animation.value * 20),
              child: _Orb(
                size: 450,
                color: secondary.withAlpha(isDark ? 25 : 30),
              ),
            ),

            // Center-right accent
            Positioned(
              top: 200 + (_animation.value * 60),
              right: 100 + (_animation.value * -30),
              child: _Orb(
                size: 300,
                color: accentBlue.withAlpha(isDark ? 15 : 20),
              ),
            ),

            // Grid overlay
            Positioned.fill(
              child: CustomPaint(painter: _GridPainter(primary)),
            ),

            // Child
            widget.child,
          ],
        );
      },
    );
  }
}

/// A soft glowing circular blob.
class _Orb extends StatelessWidget {
  final double size;
  final Color color;
  const _Orb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
          radius: 0.6,
        ),
      ),
    );
  }
}

/// Subtle dot-grid overlay painter.
class _GridPainter extends CustomPainter {
  final Color color;
  const _GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withAlpha(10)
      ..strokeWidth = 1;
    const step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter old) => old.color != color;
}
