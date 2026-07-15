import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';
import 'package:siam_portfolio/feature/home/widgets/portfolio_drawer.dart';
import 'package:siam_portfolio/feature/home/widgets/portfolio_nav_bar.dart';
import 'package:siam_portfolio/feature/home/widgets/hero_section.dart';
import 'package:siam_portfolio/feature/home/widgets/about_section.dart';
import 'package:siam_portfolio/feature/home/widgets/skills_section.dart';
import 'package:siam_portfolio/feature/home/widgets/services_section.dart';
import 'package:siam_portfolio/feature/home/widgets/experience_section.dart';
import 'package:siam_portfolio/feature/home/widgets/education_section.dart';
import 'package:siam_portfolio/feature/home/widgets/projects_section.dart';
import 'package:siam_portfolio/feature/home/widgets/certificates_section.dart';
import 'package:siam_portfolio/feature/home/widgets/achievements_section.dart';
import 'package:siam_portfolio/feature/home/widgets/tech_stack_section.dart';
import 'package:siam_portfolio/feature/home/widgets/testimonials_section.dart';
import 'package:siam_portfolio/feature/home/widgets/contact_section.dart';
import 'package:siam_portfolio/feature/home/widgets/footer_widget.dart';

/// Main portfolio home screen shell.
/// Hosts the navigation bar (desktop) or drawer (mobile) and all sections.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktopOrLarger(context);

    return Scaffold(
      backgroundColor: const Color(0xFF090818),
      drawer: isDesktop ? null : const PortfolioDrawer(),

      // Floating nav bar for desktop
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: const Color(0xFF090818),
              elevation: 0,
              iconTheme: const IconThemeData(color: Color(0xFF818CF8)),
              title: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Siam',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

      body: Stack(
        children: [
          // ── Scrollable content ───────────────────────────────────────────
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                // Desktop top nav bar spacing
                if (isDesktop) const SizedBox(height: 70),

                // ── Sections ────────────────────────────────────────────────
                HeroSection(key: controller.heroKey),
                AboutSection(key: controller.aboutKey),
                SkillsSection(key: controller.skillsKey),
                ServicesSection(key: controller.servicesKey),
                ExperienceSection(key: controller.experienceKey),
                EducationSection(key: controller.educationKey),
                ProjectsSection(key: controller.projectsKey),
                CertificatesSection(key: controller.certificatesKey),
                AchievementsSection(key: controller.achievementsKey),
                TechStackSection(key: controller.techStackKey),
                TestimonialsSection(key: controller.testimonialsKey),
                ContactSection(key: controller.contactKey),
                const FooterWidget(),
              ],
            ),
          ),

          // ── Desktop floating nav bar ─────────────────────────────────────
          if (isDesktop)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PortfolioNavBar(),
            ),
        ],
      ),
    );
  }
}
