import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/achievement_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Achievements section — counters and achievement cards.
class AchievementsSection extends GetView<HomeController> {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = ResponsiveHelper.gridColumns(context,
        mobile: 1, tablet: 2, desktop: 4);

    return PortfolioSectionWrapper(
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Achievements',
            subtitle: 'Milestones',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                mainAxisExtent: 220,
              ),
            itemCount: controller.achievements.length,
            itemBuilder: (_, i) => _AchievementCard(
              item: controller.achievements[i],
              delay: i * 100,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementModel item;
  final int delay;
  const _AchievementCard({required this.item, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF818CF8).withAlpha(20),
            const Color(0xFFA78BFA).withAlpha(10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(color: const Color(0xFF818CF8).withAlpha(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(item.icon, color: const Color(0xFF818CF8), size: 32),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF818CF8).withAlpha(20),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  item.year,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF818CF8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            item.title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.description,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.white.withAlpha(140),
              height: 1.5,
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
