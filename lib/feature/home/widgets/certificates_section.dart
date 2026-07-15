import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_primary_button.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_title.dart';
import 'package:siam_portfolio/core/common/widgets/portfolio_section_wrapper.dart';
import 'package:siam_portfolio/core/models/certificate_model.dart';
import 'package:siam_portfolio/core/utils/constants/app_dimensions.dart';
import 'package:siam_portfolio/core/utils/helpers/responsive_helper.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Certificates section with responsive grid.
class CertificatesSection extends GetView<HomeController> {
  const CertificatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cols = ResponsiveHelper.gridColumns(context,
        mobile: 1, tablet: 2, desktop: 4);

    return PortfolioSectionWrapper(
      backgroundColor: const Color(0xFF0A0A1A),
      child: Column(
        children: [
          const PortfolioSectionTitle(
            title: 'Certificates',
            subtitle: 'Credentials',
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 240,
              ),
            itemCount: controller.certificates.length,
            itemBuilder: (_, i) => _CertCard(
              cert: controller.certificates[i],
              delay: i * 80,
            ),
          ),
        ],
      ),
    );
  }
}

class _CertCard extends GetView<HomeController> {
  final CertificateModel cert;
  final int delay;
  const _CertCard({required this.cert, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1F3A).withAlpha(60),
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(color: const Color(0xFF818CF8).withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFDFAA26).withAlpha(20),
            ),
            child: const Icon(
              Icons.card_membership_rounded,
              color: Color(0xFFDFAA26),
              size: 22,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            cert.title,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            cert.organization,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF818CF8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cert.date,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white.withAlpha(100),
            ),
          ),
          const Spacer(),
          if (cert.verifyUrl != null)
            PortfolioPrimaryButton(
              label: 'Verify',
              icon: Icons.verified_rounded,
              isOutline: true,
              onTap: () => controller.launchURL(cert.verifyUrl!),
            ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.15, end: 0);
  }
}
