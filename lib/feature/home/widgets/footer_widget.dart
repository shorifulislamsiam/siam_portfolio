import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_social_button.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/core/utils/theme/app_theme_colors.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Site footer — copyright, nav links, social icons, and back-to-top.
class FooterWidget extends GetView<HomeController> {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = AppThemeColors.primary(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PortfolioSectionWrapper(
      backgroundColor: AppThemeColors.footerBg(context),
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 40),
      child: Column(
        children: [
          Divider(color: primary.withAlpha(38)),
          const SizedBox(height: 32),

          // Social links
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              PortfolioSocialButton(
                icon: Icons.code,
                onTap: () => controller.launchURL(AppStrings.githubUrl),
                tooltip: 'GitHub',
              ),
              PortfolioSocialButton(
                icon: Icons.code,
                onTap: () => controller.launchURL(AppStrings.gitLabUrl),
                tooltip: 'GitLab',
              ),
              PortfolioSocialButton(
                icon: Icons.link,
                onTap: () => controller.launchURL(AppStrings.linkedinUrl),
                tooltip: 'LinkedIn',
              ),
              PortfolioSocialButton(
                icon: Icons.email,
                onTap: () => controller.launchURL('mailto:${AppStrings.email}'),
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
              color: AppThemeColors.textHint(context),
            ),
          ),

          const SizedBox(height: 8),

          // Copyright
          Text(
            AppStrings.copyright,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isDark
                  ? Colors.white.withAlpha(80)
                  : const Color(0xFF94A3B8),
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
                color: primary.withAlpha(20),
                borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                border: Border.all(color: primary.withAlpha(60)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 14,
                    color: primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppStrings.backToTop,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: primary,
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
