import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Animated logo widget used on the Splash Screen.
class SplashLogoWidget extends StatelessWidget {
  const SplashLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo circle
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF818CF8).withAlpha(80),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'S',
              style: GoogleFonts.outfit(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        )
            .animate()
            .scale(
              begin: const Offset(0.3, 0.3),
              end: const Offset(1, 1),
              duration: 700.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(duration: 400.ms),

        const SizedBox(height: 24),

        // Name text
        Text(
          'SIAM',
          style: GoogleFonts.outfit(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 8,
          ),
        )
            .animate(delay: 400.ms)
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut),

        const SizedBox(height: 8),

        Text(
          'Flutter Developer',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF818CF8),
            letterSpacing: 3,
          ),
        )
            .animate(delay: 600.ms)
            .fadeIn(duration: 600.ms),
      ],
    );
  }
}
