import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';
import 'package:siam_portfolio/feature/Splash_screen/presentation/widget/splash_logo_widget.dart';

/// Full animated splash screen.
/// Uses a StatefulWidget timer to guarantee navigation — avoids GetX
/// initialRoute binding race conditions.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to Home after 3 seconds
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Get.offAllNamed(AppStringRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090818),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Animated background orbs
          const _BackgroundOrbs(),

          // Center content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SplashLogoWidget(),
                const SizedBox(height: 64),

                // Animated progress bar (2.8s to match navigation timer)
                SizedBox(
                  width: 120,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 2800),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: value,
                          minHeight: 3,
                          backgroundColor:
                              const Color(0xFF818CF8).withAlpha(30),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF818CF8),
                          ),
                        ),
                      );
                    },
                  ),
                ).animate(delay: 800.ms).fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated background orbs for the splash screen.
class _BackgroundOrbs extends StatelessWidget {
  const _BackgroundOrbs();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -80,
          left: -80,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF818CF8).withAlpha(40),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -60,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFA78BFA).withAlpha(30),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}