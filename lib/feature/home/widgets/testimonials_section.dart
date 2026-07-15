import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/testimonial_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Testimonials section with carousel.
class TestimonialsSection extends GetView<HomeController> {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Testimonials',
            subtitle: 'What Clients Say',
          ),
          const SizedBox(height: 48),
          Obx(
            () => _TestimonialCarousel(
              testimonials: controller.testimonials,
              currentIndex: controller.testimonialIndex.value,
              onPrev: controller.prevTestimonial,
              onNext: controller.nextTestimonial,
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCarousel extends StatelessWidget {
  final List<TestimonialModel> testimonials;
  final int currentIndex;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _TestimonialCarousel({
    required this.testimonials,
    required this.currentIndex,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (testimonials.isEmpty) return const SizedBox.shrink();
    final t = testimonials[currentIndex];

    return Column(
      children: [
        // Card
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _TestimonialCard(key: ValueKey(currentIndex), t: t),
          ),
        ),

        const SizedBox(height: 32),

        // Navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NavButton(icon: Icons.chevron_left_rounded, onTap: onPrev),
            const SizedBox(width: 16),
            // Dots
            ...testimonials.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: e.key == currentIndex ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: e.key == currentIndex
                            ? const Color(0xFF818CF8)
                            : const Color(0xFF818CF8).withAlpha(40),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
            const SizedBox(width: 16),
            _NavButton(icon: Icons.chevron_right_rounded, onTap: onNext),
          ],
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF818CF8).withAlpha(80),
          ),
        ),
        child: Icon(icon, color: const Color(0xFF818CF8), size: 24),
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final TestimonialModel t;
  const _TestimonialCard({required this.t, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F3A).withAlpha(80),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        border: Border.all(color: const Color(0xFF818CF8).withAlpha(30)),
      ),
      child: Column(
        children: [
          // Quote icon
          const Icon(
            Icons.format_quote_rounded,
            size: 40,
            color: Color(0xFF818CF8),
          ),
          const SizedBox(height: 20),

          Text(
            t.comment,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white.withAlpha(180),
              height: 1.8,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 28),

          // Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => Icon(
                i < t.rating ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 20,
                color: const Color(0xFFDFAA26),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            t.name,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${t.role} at ${t.company}',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF818CF8),
            ),
          ),
        ],
      ),
    );
  }
}
