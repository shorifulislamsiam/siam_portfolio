import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_social_button.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Site footer — copyright, nav links, social icons, and back-to-top.
class FooterWidget extends GetView<HomeController> {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF040B18),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
      child: Column(
        children: [
          const Divider(color: Color(0x26818CF8)),
          const SizedBox(height: 32),

          // Social links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              PortfolioSocialButton(
                icon: Icons.code_rounded,
                onTap: () => controller.launchURL(AppStrings.githubUrl),
                tooltip: 'GitHub',
              ),
              PortfolioSocialButton(
                icon: Icons.business_center_rounded,
                onTap: () => controller.launchURL(AppStrings.linkedinUrl),
                tooltip: 'LinkedIn',
              ),
              PortfolioSocialButton(
                icon: Icons.facebook_rounded,
                onTap: () => controller.launchURL(AppStrings.facebookUrl),
                tooltip: 'Facebook',
              ),
              PortfolioSocialButton(
                icon: Icons.mail_rounded,
                onTap: () =>
                    controller.launchURL('mailto:${AppStrings.email}'),
                tooltip: 'Email',
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Made with Flutter
          Text(
            AppStrings.madeWith,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white.withAlpha(100),
            ),
          ),

          const SizedBox(height: 8),

          // Copyright
          Text(
            AppStrings.copyright,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.white.withAlpha(80),
            ),
          ),

          const SizedBox(height: 24),

          // Back to top
          GestureDetector(
            onTap: controller.scrollToTop,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spacingLg,
                vertical: AppDimensions.spacingSm,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF818CF8).withAlpha(20),
                borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                border: Border.all(
                    color: const Color(0xFF818CF8).withAlpha(60)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward_rounded,
                      size: 14, color: Color(0xFF818CF8)),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.backToTop,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF818CF8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 700.ms);
  }
}
