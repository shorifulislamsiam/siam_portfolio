import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Tech Stack section — animated tag cloud.
class TechStackSection extends GetView<HomeController> {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Tech Stack',
            subtitle: 'Tools & Technologies',
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: controller.techStack
                .asMap()
                .entries
                .map(
                  (e) => _TechTag(label: e.value, delay: e.key * 40),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatefulWidget {
  final String label;
  final int delay;
  const _TechTag({required this.label, required this.delay});

  @override
  State<_TechTag> createState() => _TechTagState();
}

class _TechTagState extends State<_TechTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingMd,
        ),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFF818CF8)
              : const Color(0xFF818CF8).withAlpha(15),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: const Color(0xFF818CF8).withAlpha(_hovered ? 255 : 60),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF818CF8).withAlpha(50),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _hovered ? Colors.white : const Color(0xFF818CF8),
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: widget.delay))
        .fadeIn(duration: 400.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.elasticOut,
        );
  }
}
