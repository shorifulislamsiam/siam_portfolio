import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Mobile/tablet drawer navigation.
class PortfolioDrawer extends GetView<HomeController> {
  const PortfolioDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F0F1E),
      width: 280,
      child: Column(
        children: [
          // Header
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withAlpha(30),
                  ),
                  child: Center(
                    child: Text(
                      'S',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.fullName,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AppStrings.designation,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withAlpha(180),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Nav items — scrollable so they never overflow on small screens
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: _buildNavItems(context),
            ),
          ),

          // Theme toggle pinned at bottom
          const Divider(color: Colors.white12, height: 1),
          ListTile(
            leading: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: const Color(0xFF818CF8),
            ),
            title: Text(
              Theme.of(context).brightness == Brightness.dark
                  ? 'Light Mode'
                  : 'Dark Mode',
              style: GoogleFonts.inter(
                color: Colors.white.withAlpha(180),
                fontSize: 14,
              ),
            ),
            onTap: () {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 8),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    final items = [
      (Icons.home_rounded, 'Home', controller.heroKey, 0),
      (Icons.person_rounded, 'About', controller.aboutKey, 1),
      (Icons.psychology_rounded, 'Skills', controller.skillsKey, 2),
      (Icons.design_services_rounded, 'Services', controller.servicesKey, 3),
      (Icons.work_rounded, 'Experience', controller.experienceKey, 4),
      (Icons.school_rounded, 'Education', controller.educationKey, 5),
      (Icons.folder_rounded, 'Projects', controller.projectsKey, 6),
      (Icons.card_membership_rounded, 'Certificates', controller.certificatesKey, 7),
      (Icons.mail_rounded, 'Contact', controller.contactKey, 8),
    ];

    return items
        .map(
          (item) => Obx(
            () => ListTile(
              leading: Icon(
                item.$1,
                color: controller.activeNavIndex.value == item.$4
                    ? const Color(0xFF818CF8)
                    : Colors.white.withAlpha(120),
                size: 20,
              ),
              title: Text(
                item.$2,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: controller.activeNavIndex.value == item.$4
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: controller.activeNavIndex.value == item.$4
                      ? const Color(0xFF818CF8)
                      : Colors.white.withAlpha(180),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                controller.scrollToSection(item.$3, item.$4);
              },
            ),
          ),
        )
        .toList();
  }
}
