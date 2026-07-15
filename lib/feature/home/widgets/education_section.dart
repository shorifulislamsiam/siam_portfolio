import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/education_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Education section with timeline cards.
class EducationSection extends GetView<HomeController> {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Education',
            subtitle: 'Academic Background',
          ),
          const SizedBox(height: 48),
          ...controller.education.asMap().entries.map(
                (e) => _EducationCard(
                  edu: e.value,
                  isLast: e.key == controller.education.length - 1,
                  delay: e.key * 150,
                ),
              ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final EducationModel edu;
  final bool isLast;
  final int delay;

  const _EducationCard({
    required this.edu,
    required this.isLast,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: AppDimensions.timelineDotSize,
                  height: AppDimensions.timelineDotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFA78BFA),
                    border: Border.all(
                      color: const Color(0xFFA78BFA),
                      width: 2,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: AppDimensions.timelineLineWidth,
                      color: const Color(0xFFA78BFA).withAlpha(40),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.cardPadding),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1F3A).withAlpha(60),
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                  border: Border.all(
                    color: const Color(0xFFA78BFA).withAlpha(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.institution,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: const Color(0xFFA78BFA),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${edu.field} • ${edu.duration}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                    if (edu.cgpa != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDFAA26).withAlpha(20),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: const Color(0xFFDFAA26).withAlpha(60)),
                        ),
                        child: Text(
                          'CGPA: ${edu.cgpa}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFFDFAA26),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (edu.description != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        edu.description!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withAlpha(140),
                          height: 1.6,
                        ),
                      ),
                    ],
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
        .slideX(begin: 0.1, end: 0);
  }
}
