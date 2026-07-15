import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/service_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Services offered section — responsive card grid.
class ServicesSection extends GetView<HomeController> {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = ResponsiveHelper.gridColumns(context,
        mobile: 1, tablet: 2, desktop: 3);

    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Services',
            subtitle: 'What I Offer',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                mainAxisExtent: 240,
              ),
            itemCount: controller.services.length,
            itemBuilder: (_, i) => _ServiceCard(
              service: controller.services[i],
              delay: i * 80,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;
  final int delay;
  const _ServiceCard({required this.service, required this.delay});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(AppDimensions.cardPadding),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFF818CF8).withAlpha(20)
              : const Color(0xFF1E1F3A).withAlpha(60),
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF818CF8).withAlpha(100)
                : const Color(0xFF818CF8).withAlpha(25),
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF818CF8).withAlpha(30),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF818CF8).withAlpha(20),
              ),
              child: Icon(
                widget.service.icon,
                color: const Color(0xFF818CF8),
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.service.title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.service.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.white.withAlpha(140),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: widget.delay))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.2, end: 0);
  }
}
