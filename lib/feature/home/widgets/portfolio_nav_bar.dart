import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Desktop top navigation bar with active indicator, hover effects, and theme toggle.
class PortfolioNavBar extends GetView<HomeController> {
  const PortfolioNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final scrolled = controller.isNavScrolled.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 70,
        decoration: BoxDecoration(
          color: scrolled
              ? const Color(0xFF090818).withAlpha(230)
              : Colors.transparent,
          border: scrolled
              ? Border(
                  bottom: BorderSide(
                    color: const Color(0xFF818CF8).withAlpha(30),
                    width: 1,
                  ),
                )
              : null,
          boxShadow: scrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Row(
            children: [
              // Logo / Name
              _Logo(),

              const Spacer(),

              // Nav items
              Row(
                children: _buildNavItems(context),
              ),

              const SizedBox(width: 24),

              // Theme toggle
              _ThemeToggle(),
            ],
          ),
        ),
      ).animate().slideY(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOut);
    });
  }

  List<Widget> _buildNavItems(BuildContext context) {
    final items = [
      ('Home', controller.heroKey, 0),
      ('About', controller.aboutKey, 1),
      ('Skills', controller.skillsKey, 2),
      ('Services', controller.servicesKey, 3),
      ('Experience', controller.experienceKey, 4),
      ('Projects', controller.projectsKey, 5),
      ('Contact', controller.contactKey, 6),
    ];

    return items
        .map((item) => _NavItem(
              label: item.$1,
              index: item.$3,
              onTap: () => controller.scrollToSection(item.$2, item.$3),
            ))
        .toList();
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF818CF8), Color(0xFFA78BFA)],
            ),
          ),
          child: Center(
            child: Text(
              'S',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          AppStrings.name,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _NavItem extends GetView<HomeController> {
  final String label;
  final int index;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isActive = controller.activeNavIndex.value == index;
      return _HoverNavItem(
        label: label,
        isActive: isActive,
        onTap: onTap,
      );
    });
  }
}

class _HoverNavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _HoverNavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF818CF8);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  color: widget.isActive || _hovered
                      ? accent
                      : Colors.white.withAlpha(180),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: widget.isActive || _hovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () => Get.changeThemeMode(
        isDark ? ThemeMode.light : ThemeMode.dark,
      ),
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: const Color(0xFF818CF8),
        size: 22,
      ),
      tooltip: isDark ? 'Light Mode' : 'Dark Mode',
    );
  }
}
