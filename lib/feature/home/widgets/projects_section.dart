import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/project_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Projects section with category filter and responsive grid of project cards.
class ProjectsSection extends GetView<HomeController> {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      child: Column(
        children: [
          const PortfolioSectionTitle(title: 'Projects', subtitle: 'My Work'),
          const SizedBox(height: 32),

          // Category filter chips
          Obx(
            () => Wrap(
              spacing: 12,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: controller.projectCategories
                  .map(
                    (cat) => _FilterChip(
                      label: cat,
                      isSelected: controller.selectedCategory.value == cat,
                      onTap: () => controller.filterProjects(cat),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 40),

          // Project grid — Wrap-based so cards size to their content
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = ResponsiveHelper.gridColumns(
                context,
                mobile: 1,
                tablet: 2,
                desktop: 3,
              );
              final totalSpacing = 24.0 * (cols - 1);
              final cardWidth =
                  (constraints.maxWidth - totalSpacing) / cols;

              return Obx(() {
                final projects = controller.filteredProjects;

                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: List.generate(
                    projects.length,
                    (i) => SizedBox(
                      width: cardWidth,
                      child: _ProjectCard(
                        project: projects[i],
                        delay: i * 80,
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF818CF8)
              : const Color(0xFF818CF8).withAlpha(20),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: const Color(0xFF818CF8).withAlpha(isSelected ? 255 : 80),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : const Color(0xFF818CF8),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends GetView<HomeController> {
  final ProjectModel project;
  final int delay;

  const _ProjectCard({required this.project, required this.delay});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () =>
              Get.toNamed(AppStringRoutes.projectDetail, arguments: project),
          child: _HoverProjectCard(project: project, controller: controller),
        )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.15, end: 0);
  }
}

class _HoverProjectCard extends StatefulWidget {
  final ProjectModel project;
  final HomeController controller;
  const _HoverProjectCard({required this.project, required this.controller});

  @override
  State<_HoverProjectCard> createState() => _HoverProjectCardState();
}

class _HoverProjectCardState extends State<_HoverProjectCard> {
  bool _hovered = false;

  bool get _hasGithub =>
      widget.project.githubUrl != null &&
      widget.project.githubUrl!.isNotEmpty;

  bool get _hasLiveDemo =>
      widget.project.liveDemoUrl != null &&
      widget.project.liveDemoUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: _hovered
              ? const Color(0xFF818CF8).withAlpha(15)
              : const Color(0xFF1E1F3A).withAlpha(60),
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF818CF8).withAlpha(120)
                : const Color(0xFF818CF8).withAlpha(25),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF818CF8).withAlpha(25),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Project image / placeholder
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppDimensions.cardRadius),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF25233E), Color(0xFF1A1A2E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.folder_open_rounded,
                      size: 48,
                      color: const Color(0xFF818CF8).withAlpha(80),
                    ),
                  ),
                ),
              ),
            ),

            // Content section — no fixed height, sizes to content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Featured badge
                  if (widget.project.isFeatured) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFAA26).withAlpha(20),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: const Color(0xFFDFAA26).withAlpha(60),
                        ),
                      ),
                      child: Text(
                        '⭐ Featured',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: const Color(0xFFDFAA26),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    widget.project.title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.project.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withAlpha(140),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: widget.project.technologies
                        .take(3)
                        .map((t) => _TechTag(label: t))
                        .toList(),
                  ),

                  // Buttons — only rendered when URLs exist, no extra space otherwise
                  if (_hasGithub || _hasLiveDemo) ...[
                    const SizedBox(height: 16),
                    if (_hasGithub)
                      PortfolioPrimaryButton(
                        label: AppStrings.sourceCode,
                        icon: Icons.code_rounded,
                        isOutline: true,
                        onTap: () => widget.controller.launchURL(
                          widget.project.githubUrl!,
                        ),
                      ),
                    if (_hasGithub && _hasLiveDemo)
                      const SizedBox(height: 8),
                    if (_hasLiveDemo)
                      PortfolioPrimaryButton(
                        label: AppStrings.liveDemo,
                        icon: Icons.open_in_new_rounded,
                        onTap: () => widget.controller.launchURL(
                          widget.project.liveDemoUrl!,
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF818CF8).withAlpha(15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF818CF8).withAlpha(40)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          color: const Color(0xFF818CF8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
