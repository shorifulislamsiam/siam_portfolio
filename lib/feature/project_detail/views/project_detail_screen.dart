import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';
import 'package:siam_portfolio/feature/project_detail/controllers/project_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

/// Project Detail Screen — shown when user taps a project card.
class ProjectDetailScreen extends GetView<ProjectDetailController> {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = controller.project;
    if (project == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF090818),
        body: Center(
          child: Text('Project not found',
              style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF090818),
      appBar: AppBar(
        backgroundColor: const Color(0xFF090818),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: Color(0xFF818CF8)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          project.title,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.spacingXl),
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.cardRadius),
                  child: Container(
                    height: 300,
                    width: double.infinity,
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
                        size: 80,
                        color: const Color(0xFF818CF8).withAlpha(80),
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms),

                const SizedBox(height: 32),

                // Featured badge
                if (project.isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFAA26).withAlpha(20),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: const Color(0xFFDFAA26).withAlpha(60)),
                    ),
                    child: Text(
                      '⭐ Featured Project',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: const Color(0xFFDFAA26),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ).animate(delay: 200.ms).fadeIn(),

                const SizedBox(height: 16),

                Text(
                  project.title,
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ).animate(delay: 300.ms).fadeIn(),

                const SizedBox(height: 12),
                Text(
                  project.description,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white.withAlpha(160),
                    height: 1.8,
                  ),
                ).animate(delay: 400.ms).fadeIn(),

                const SizedBox(height: 24),

                Text(
                  'Technologies Used',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: project.technologies
                      .map(
                        (t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF818CF8).withAlpha(20),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: const Color(0xFF818CF8).withAlpha(60)),
                          ),
                          child: Text(
                            t,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: const Color(0xFF818CF8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ).animate(delay: 500.ms).fadeIn(),

                const SizedBox(height: 32),

                // CTA buttons
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    if (project.githubUrl != null)
                      PortfolioPrimaryButton(
                        label: AppStrings.sourceCode,
                        icon: Icons.code_rounded,
                        isOutline: true,
                        onTap: () => _launch(project.githubUrl!),
                      ),
                    if (project.liveDemoUrl != null &&
                        project.liveDemoUrl!.isNotEmpty)
                      PortfolioPrimaryButton(
                        label: AppStrings.liveDemo,
                        icon: Icons.open_in_new_rounded,
                        onTap: () => _launch(project.liveDemoUrl!),
                      ),
                  ],
                ).animate(delay: 600.ms).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
