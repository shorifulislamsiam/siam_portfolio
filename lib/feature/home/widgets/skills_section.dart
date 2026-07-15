import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/skill_model.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Skills section with animated progress bars.
class SkillsSection extends GetView<HomeController> {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = ResponsiveHelper.gridColumns(context,
        mobile: 1, tablet: 2, desktop: 2);

    return PortfolioSectionWrapper(
      child: Column(
        children: [
          const PortfolioSectionTitle(title: 'Skills', subtitle: 'What I Know'),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 70,
            ),
            itemCount: controller.skills.length,
            itemBuilder: (_, i) => _SkillBar(
              skill: controller.skills[i],
              delay: i * 80,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatefulWidget {
  final SkillModel skill;
  final int delay;
  const _SkillBar({required this.skill, required this.delay});

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 && !_visible) {
      _visible = true;
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('skill_${widget.skill.name}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.skill.name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withAlpha(200),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (_, child) => Text(
                  '${(_animation.value * widget.skill.percentage * 100).toInt()}%',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: widget.skill.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _animation.value * widget.skill.percentage,
                  minHeight: 8,
                  backgroundColor: const Color(0xFF1E1F3A),
                  valueColor: AlwaysStoppedAnimation<Color>(widget.skill.color),
                ),
              );
            },
          ),
        ],
      ).animate(delay: Duration(milliseconds: widget.delay)).fadeIn(duration: 400.ms),
    );
  }
}
