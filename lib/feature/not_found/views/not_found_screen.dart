import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';

/// 404 Not Found screen.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090818),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large 404 text
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
              ).createShader(bounds),
              child: Text(
                '404',
                style: GoogleFonts.outfit(
                  fontSize: 120,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            )
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 700.ms,
                  curve: Curves.elasticOut,
                )
                .fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            Text(
              'Page Not Found',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 12),

            Text(
              "The page you're looking for doesn't exist or has been moved.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withAlpha(140),
                height: 1.6,
              ),
            ).animate(delay: 400.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 40),

            PortfolioPrimaryButton(
              label: 'Back to Home',
              icon: Icons.home_rounded,
              onTap: () => Get.offAllNamed(AppStringRoutes.home),
            ).animate(delay: 500.ms).fadeIn(duration: 500.ms),
          ],
        ),
      ),
    );
  }
}
