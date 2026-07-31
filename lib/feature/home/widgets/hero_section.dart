import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_animated_background.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_social_button.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/core/utils/theme/app_theme_colors.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Hero Section — the first thing visitors see.
/// Full-height with animated text, CTA buttons, and social links.
class HeroSection extends GetView<HomeController> {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final isDesktop = ResponsiveHelper.isDesktopOrLarger(context);

    return PortfolioAnimatedBackground(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: isMobile ? 600 : MediaQuery.sizeOf(context).height,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.sectionHPadding(context),
              vertical: 80,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppDimensions.maxContentWidth,
              ),
              child: isDesktop ? _DesktopHeroContent() : _MobileHeroContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileHeroContent extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProfileAvatar(),
        const SizedBox(height: 32),
        _HeroText(centerAlign: true),
        const SizedBox(height: 32),
        _CTAButtons(),
        const SizedBox(height: 24),
        _SocialLinks(),
        const SizedBox(height: 24),
        _LocationChip(),
      ],
    );
  }
}

class _DesktopHeroContent extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroText(centerAlign: false),
              const SizedBox(height: 36),
              _CTAButtons(),
              const SizedBox(height: 28),
              _SocialLinks(),
              const SizedBox(height: 20),
              _LocationChip(),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: Center(child: _ProfileAvatar())),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary   = AppThemeColors.primary(context);
    final secondary = AppThemeColors.secondary(context);
    final size = ResponsiveHelper.isMobile(context)
        ? AppDimensions.profileImageSizeMobile
        : AppDimensions.profileImageSize;

    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primary.withAlpha(60),
                blurRadius: 40,
                spreadRadius: 4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Placeholder when no image is provided
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF1E1F3A), const Color(0xFF25233E)]
                          : [const Color(0xFFE0F2FE), const Color(0xFFBAE6FD)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Text(
                  'S',
                  style: GoogleFonts.outfit(
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.w700,
                    color: primary.withAlpha(80),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 600.ms);
  }
}

class _HeroText extends StatelessWidget {
  final bool centerAlign;
  const _HeroText({required this.centerAlign});

  @override
  Widget build(BuildContext context) {
    final primary   = AppThemeColors.primary(context);
    final secondary = AppThemeColors.secondary(context);
    final align = centerAlign
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: align,
      children: [
        // Greeting
        Text(
          'Hi there, I am 👋',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: primary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: textAlign,
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.3),

        const SizedBox(height: 12),

        // Name
        Text(
          AppStrings.fullName,
          textAlign: textAlign,
          style: GoogleFonts.outfit(
            fontSize: ResponsiveHelper.isMobile(context) ? 36 : 52,
            fontWeight: FontWeight.w800,
            color: AppThemeColors.textMain(context),
            height: 1.1,
          ),
        ).animate(delay: 150.ms).fadeIn(duration: 500.ms).slideY(begin: 0.3),

        const SizedBox(height: 16),

        // Animated typing text
        DefaultTextStyle(
          style: GoogleFonts.outfit(
            fontSize: ResponsiveHelper.isMobile(context) ? 20 : 28,
            fontWeight: FontWeight.w600,
            color: secondary,
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: AppStrings.typingTexts
                .map(
                  (text) => TypewriterAnimatedText(
                    text,
                    speed: const Duration(milliseconds: 80),
                    cursor: '|',
                  ),
                )
                .toList(),
          ),
        ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

        const SizedBox(height: 20),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            AppStrings.bio,
            textAlign: textAlign,
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppThemeColors.textSubtle(context),
              height: 1.7,
            ),
          ),
        ).animate(delay: 450.ms).fadeIn(duration: 500.ms),
      ],
    );
  }
}

class _CTAButtons extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        PortfolioPrimaryButton(
          label: AppStrings.downloadResume,
          icon: Icons.download_rounded,
          onTap: () => controller.launchURL(AppStrings.resumeUrl),
        ),
        PortfolioPrimaryButton(
          label: AppStrings.hireMe,
          icon: Icons.mail_outline_rounded,
          isOutline: true,
          onTap: () => controller.scrollToSection(controller.contactKey, 6),
        ),
      ],
    ).animate(delay: 600.ms).fadeIn(duration: 500.ms);
  }
}

class _SocialLinks extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        PortfolioSocialButton(
          icon: Icons.code,
          onTap: () => controller.launchURL(AppStrings.githubUrl),
          tooltip: 'GitHub',
        ),
        PortfolioSocialButton(
          icon: Icons.build,
          onTap: () => controller.launchURL(AppStrings.gitLabUrl),
          tooltip: 'GitLab',
        ),
        PortfolioSocialButton(
          icon: Icons.link,
          onTap: () => controller.launchURL(AppStrings.linkedinUrl),
          tooltip: 'LinkedIn',
        ),
        // PortfolioSocialButton(
        //   icon: Icons.facebook_rounded,
        //   onTap: () => controller.launchURL(AppStrings.facebookUrl),
        //   tooltip: 'Facebook',
        // ),
        PortfolioSocialButton(
          icon: Icons.email,
          onTap: () => controller.launchURL('mailto:${AppStrings.email}'),
          tooltip: 'Email',
        ),
      ],
    ).animate(delay: 750.ms).fadeIn(duration: 500.ms);
  }
}

class _LocationChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final primary = AppThemeColors.primary(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withAlpha(20),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(color: primary.withAlpha(50)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_rounded,
            size: 14,
            color: primary,
          ),
          const SizedBox(width: 6),
          Text(
            AppStrings.location,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: primary,
            ),
          ),
        ],
      ),
    ).animate(delay: 900.ms).fadeIn(duration: 500.ms);
  }
}
