import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/utils/constants/app_strings.dart';

import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Contact section with validated form and contact info.
class ContactSection extends GetView<HomeController> {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Contact Me',
            subtitle: "Let's Work Together",
          ),
          const SizedBox(height: 48),
          ResponsiveHelper.isDesktopOrLarger(context)
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: _ContactInfo()),
                    const SizedBox(width: 60),
                    Expanded(flex: 6, child: _ContactForm()),
                  ],
                )
              : Column(
                  children: [
                    _ContactInfo(),
                    const SizedBox(height: 40),
                    _ContactForm(),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactInfo extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.location_on_rounded, 'Location', AppStrings.location),
      (Icons.email_rounded, 'Email', AppStrings.email),
      (Icons.phone_rounded, 'Phone', AppStrings.phone),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Get In Touch",
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 12),
        Text(
          "I'm currently available for freelance work and full-time positions. "
          "If you have a project that needs Flutter expertise, let's talk!",
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white.withAlpha(150),
            height: 1.7,
          ),
        ).animate(delay: 100.ms).fadeIn(duration: 500.ms),
        const SizedBox(height: 32),
        ...items.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF818CF8).withAlpha(20),
                        border: Border.all(
                            color: const Color(0xFF818CF8).withAlpha(50)),
                      ),
                      child: Icon(e.value.$1,
                          color: const Color(0xFF818CF8), size: 20),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.$2,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: const Color(0xFF818CF8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          e.value.$3,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate(delay: Duration(milliseconds: (e.key + 1) * 100)).fadeIn(duration: 500.ms),
            ),
      ],
    );
  }
}

class _ContactForm extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField(
            label: 'Your Name',
            controller: controller.nameController,
            icon: Icons.person_outline_rounded,
            validator: (v) =>
                v == null || v.isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Your Email',
            controller: controller.emailController,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              if (!GetUtils.isEmail(v)) return 'Enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Subject',
            controller: controller.subjectController,
            icon: Icons.subject_rounded,
            validator: (v) =>
                v == null || v.isEmpty ? 'Subject is required' : null,
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Message',
            controller: controller.messageController,
            icon: Icons.message_outlined,
            maxLines: 5,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Message is required';
              if (v.length < 20) return 'Message must be at least 20 characters';
              return null;
            },
          ),
          const SizedBox(height: 24),
          Obx(
            () => controller.isSendingMessage.value
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xFF818CF8)),
                    ),
                  )
                : PortfolioPrimaryButton(
                    label: AppStrings.sendMessage,
                    icon: Icons.send_rounded,
                    onTap: controller.sendMessage,
                  ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.white.withAlpha(200),
      ),
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF818CF8), size: 20),
      ),
    );
  }
}
