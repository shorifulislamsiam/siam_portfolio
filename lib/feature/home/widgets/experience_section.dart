import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/experience_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Work experience section with vertical timeline.
class ExperienceSection extends GetView<HomeController> {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Experience',
            subtitle: 'Work History',
          ),
          const SizedBox(height: 48),
          ...controller.experiences.asMap().entries.map(
                (e) => _TimelineCard(
                  experience: e.value,
                  isLast: e.key == controller.experiences.length - 1,
                  delay: e.key * 150,
                ),
              ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;
  final int delay;

  const _TimelineCard({
    required this.experience,
    required this.isLast,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline dot + line
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: AppDimensions.timelineDotSize,
                  height: AppDimensions.timelineDotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: experience.isCurrent
                        ? const Color(0xFF818CF8)
                        : const Color(0xFF818CF8).withAlpha(100),
                    border: Border.all(
                      color: const Color(0xFF818CF8),
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: AppDimensions.timelineLineWidth,
                      color: const Color(0xFF818CF8).withAlpha(40),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.cardPadding),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1F3A).withAlpha(60),
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                  border: Border.all(
                    color: const Color(0xFF818CF8).withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          experience.position,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        if (experience.isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF34D399).withAlpha(25),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color(0xFF34D399).withAlpha(60)),
                            ),
                            child: Text(
                              'Current',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: const Color(0xFF34D399),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      experience.company,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFF818CF8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      experience.duration,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      experience.description,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withAlpha(160),
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: experience.technologies
                          .map(
                            (tech) => _TechChip(label: tech),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.1, end: 0);
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF818CF8).withAlpha(20),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF818CF8).withAlpha(50)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          color: const Color(0xFF818CF8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
