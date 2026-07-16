import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// About Me section — career summary, personal info, and mission statement.
class AboutSection extends GetView<HomeController> {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(title: 'About Me', subtitle: 'Who I Am'),
          const SizedBox(height: 48),
          ResponsiveHelper.isDesktopOrLarger(context)
              ? _DesktopAbout()
              : _MobileAbout(),
        ],
      ),
    );
  }
}

class _MobileAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_AboutText(), const SizedBox(height: 40), _InfoGrid()],
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _AboutText()),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: _InfoGrid()),
      ],
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.about,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white.withAlpha(180),
            height: 1.8,
          ),
        ).animate().fadeIn(duration: 700.ms),
        const SizedBox(height: 24),
        Text(
          'I believe in building products that not only look great but are '
          'also maintainable, scalable, and performant. My code is clean, '
          'well-documented, and follows SOLID principles.',
          style: GoogleFonts.inter(
            fontSize: 15,
            color: Colors.white.withAlpha(140),
            height: 1.8,
          ),
        ).animate(delay: 200.ms).fadeIn(duration: 700.ms),
        const SizedBox(height: 32),
        _AvailabilityChip(),
      ],
    );
  }
}

class _AvailabilityChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF34D399).withAlpha(20),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF34D399).withAlpha(60)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF34D399),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Available for Freelance & Full-time',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF34D399),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate(delay: 400.ms).fadeIn(duration: 500.ms);
  }
}

class _InfoGrid extends StatelessWidget {
  final _info = const [
    ('Name', AppStrings.fullName),
    ('Email', AppStrings.email),
    ('Phone', AppStrings.phone),
    ('Location', AppStrings.location),
    ('Education', 'B.Sc. in CSE (Running)'),
    ('Experience', '1 year (Including Internships)'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _info
          .asMap()
          .entries
          .map(
            (e) => _InfoCard(
              label: e.value.$1,
              value: e.value.$2,
              delay: e.key * 100,
            ),
          )
          .toList(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final int delay;

  const _InfoCard({
    required this.label,
    required this.value,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1F3A).withAlpha(80),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF818CF8).withAlpha(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF818CF8),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
