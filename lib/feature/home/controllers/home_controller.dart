import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siam_portfolio/core/models/project_model.dart';
import 'package:siam_portfolio/core/models/skill_model.dart';
import 'package:siam_portfolio/core/models/experience_model.dart';
import 'package:siam_portfolio/core/models/education_model.dart';
import 'package:siam_portfolio/core/models/certificate_model.dart';
import 'package:siam_portfolio/core/models/testimonial_model.dart';
import 'package:siam_portfolio/core/models/service_model.dart';
import 'package:siam_portfolio/core/models/achievement_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Main HomeController — manages navigation, scroll, data, and contact form.
class HomeController extends GetxController {
  // ── Scroll ─────────────────────────────────────────────────────────────────
  final scrollController = ScrollController();

  // Section keys for smooth scroll
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final servicesKey = GlobalKey();
  final experienceKey = GlobalKey();
  final educationKey = GlobalKey();
  final projectsKey = GlobalKey();
  final certificatesKey = GlobalKey();
  final achievementsKey = GlobalKey();
  final techStackKey = GlobalKey();
  final testimonialsKey = GlobalKey();
  final contactKey = GlobalKey();

  // ── Nav State ──────────────────────────────────────────────────────────────
  final activeNavIndex = 0.obs;
  final isNavScrolled = false.obs;

  // ── Projects Filter ────────────────────────────────────────────────────────
  final selectedCategory = 'All'.obs;
  final _allProjects = <ProjectModel>[].obs;
  final filteredProjects = <ProjectModel>[].obs;

  // ── Contact Form ───────────────────────────────────────────────────────────
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isSendingMessage = false.obs;

  // ── Testimonials Carousel ─────────────────────────────────────────────────
  final testimonialIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  void _onScroll() {
    isNavScrolled.value = scrollController.offset > 20;
  }

  // ── Data ───────────────────────────────────────────────────────────────────
  void _loadData() {
    _allProjects.assignAll(_buildProjects());
    filteredProjects.assignAll(_allProjects);
  }

  void filterProjects(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredProjects.assignAll(_allProjects);
    } else {
      filteredProjects
          .assignAll(_allProjects.where((p) => p.category == category));
    }
  }

  void nextTestimonial() {
    final count = testimonials.length;
    testimonialIndex.value = (testimonialIndex.value + 1) % count;
  }

  void prevTestimonial() {
    final count = testimonials.length;
    testimonialIndex.value =
        (testimonialIndex.value - 1 + count) % count;
  }

  // ── Scroll To Section ─────────────────────────────────────────────────────
  void scrollToSection(GlobalKey key, int navIndex) {
    activeNavIndex.value = navIndex;
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
    );
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
    activeNavIndex.value = 0;
  }

  // ── URL Launcher ──────────────────────────────────────────────────────────
  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ── Contact Form ───────────────────────────────────────────────────────────
  Future<void> sendMessage() async {
    if (!formKey.currentState!.validate()) return;
    isSendingMessage.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    isSendingMessage.value = false;
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    Get.snackbar(
      '✅ Message Sent!',
      'Thank you for reaching out. I will get back to you soon.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF818CF8),
      colorText: Colors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  // ── Portfolio Data ─────────────────────────────────────────────────────────

  List<ProjectModel> _buildProjects() => [
        const ProjectModel(
          id: '1',
          title: 'E-Commerce App',
          description:
              'A full-featured shopping app with product catalog, cart, wishlist, '
              'payment integration, and order tracking. Built with Flutter and GetX.',
          imageUrl: '',
          technologies: ['Flutter', 'GetX', 'Firebase', 'Stripe'],
          githubUrl: 'https://github.com/siam',
          liveDemoUrl: '',
          category: 'Mobile',
          isFeatured: true,
        ),
        const ProjectModel(
          id: '2',
          title: 'Portfolio Website',
          description:
              'This portfolio — a fully responsive Flutter web app with animated '
              'sections, dark/light theme, and smooth scroll navigation.',
          imageUrl: '',
          technologies: ['Flutter', 'GetX', 'Flutter Animate'],
          githubUrl: 'https://github.com/siam',
          liveDemoUrl: '',
          category: 'Web',
          isFeatured: true,
        ),
        const ProjectModel(
          id: '3',
          title: 'Task Manager',
          description:
              'A productivity app with task lists, deadlines, reminders, and '
              'offline-first sync powered by SQLite.',
          imageUrl: '',
          technologies: ['Flutter', 'SQLite', 'Riverpod'],
          githubUrl: 'https://github.com/siam',
          category: 'Mobile',
        ),
        const ProjectModel(
          id: '4',
          title: 'Chat Application',
          description:
              'Real-time chat app with rooms, direct messages, file sharing, '
              'and push notifications using Firebase.',
          imageUrl: '',
          technologies: ['Flutter', 'Firebase', 'GetX'],
          githubUrl: 'https://github.com/siam',
          category: 'Mobile',
        ),
        const ProjectModel(
          id: '5',
          title: 'Food Delivery',
          description:
              'Restaurant listing, menu, cart, live order tracking with animated '
              'map — cross-platform Flutter app.',
          imageUrl: '',
          technologies: ['Flutter', 'Google Maps', 'REST API'],
          githubUrl: 'https://github.com/siam',
          category: 'Mobile',
          isFeatured: true,
        ),
        const ProjectModel(
          id: '6',
          title: 'Admin Dashboard',
          description:
              'A responsive web dashboard with charts, data tables, and CRUD '
              'operations built with Flutter Web.',
          imageUrl: '',
          technologies: ['Flutter Web', 'GetX', 'REST API'],
          githubUrl: 'https://github.com/siam',
          category: 'Web',
        ),
      ];

  List<SkillModel> get skills => [
        SkillModel(
          name: 'Flutter',
          percentage: 0.92,
          color: const Color(0xFF818CF8),
          category: 'Frontend',
        ),
        SkillModel(
          name: 'Dart',
          percentage: 0.90,
          color: const Color(0xFF56BEFF),
          category: 'Language',
        ),
        SkillModel(
          name: 'GetX',
          percentage: 0.88,
          color: const Color(0xFFA78BFA),
          category: 'State Management',
        ),
        SkillModel(
          name: 'Firebase',
          percentage: 0.82,
          color: const Color(0xFFDFAA26),
          category: 'Backend',
        ),
        SkillModel(
          name: 'REST API',
          percentage: 0.85,
          color: const Color(0xFF34D399),
          category: 'Backend',
        ),
        SkillModel(
          name: 'Git / GitHub',
          percentage: 0.88,
          color: const Color(0xFF919EAB),
          category: 'DevOps',
        ),
        SkillModel(
          name: 'UI/UX Design',
          percentage: 0.78,
          color: const Color(0xFFFF6B6B),
          category: 'Design',
        ),
        SkillModel(
          name: 'SQLite / Hive',
          percentage: 0.80,
          color: const Color(0xFF4BC0C8),
          category: 'Database',
        ),
      ];

  List<ExperienceModel> get experiences => [
        const ExperienceModel(
          company: 'Tech Solutions Ltd.',
          position: 'Junior Flutter Developer',
          duration: 'Jan 2024 – Present',
          description:
              'Building cross-platform mobile applications using Flutter and GetX. '
              'Collaborating with designers and backend engineers to deliver '
              'production-ready features.',
          technologies: ['Flutter', 'GetX', 'REST API', 'Firebase'],
          isCurrent: true,
        ),
        const ExperienceModel(
          company: 'Freelance',
          position: 'Flutter Developer',
          duration: 'Jun 2023 – Dec 2023',
          description:
              'Developed custom Flutter apps for clients across e-commerce, '
              'healthcare, and productivity domains.',
          technologies: ['Flutter', 'Dart', 'Firebase', 'Figma'],
        ),
      ];

  List<EducationModel> get education => [
        const EducationModel(
          institution: 'University of Dhaka',
          degree: 'Bachelor of Science',
          field: 'Computer Science & Engineering',
          duration: '2020 – 2024',
          cgpa: '3.75 / 4.00',
          description:
              'Focused on software engineering, algorithms, and mobile application development.',
        ),
      ];

  List<CertificateModel> get certificates => [
        const CertificateModel(
          title: 'Flutter & Dart — The Complete Guide',
          organization: 'Udemy',
          date: 'Mar 2023',
        ),
        const CertificateModel(
          title: 'Firebase for Flutter Developers',
          organization: 'Google Developers',
          date: 'Jun 2023',
        ),
        const CertificateModel(
          title: 'Clean Architecture in Flutter',
          organization: 'Udemy',
          date: 'Oct 2023',
        ),
        const CertificateModel(
          title: 'UI/UX Fundamentals',
          organization: 'Coursera',
          date: 'Jan 2024',
        ),
      ];

  List<TestimonialModel> get testimonials => [
        const TestimonialModel(
          name: 'Ahmed Rahman',
          role: 'Product Manager',
          company: 'StartupBD',
          comment:
              'Siam delivered a beautiful, production-quality app ahead of schedule. '
              'His attention to UI details and clean code structure is impressive.',
          rating: 5.0,
        ),
        const TestimonialModel(
          name: 'Sarah Johnson',
          role: 'CEO',
          company: 'TechVentures',
          comment:
              'Exceptional work! The app Siam built for us runs flawlessly across '
              'Android, iOS, and Web. Highly recommended.',
          rating: 5.0,
        ),
        const TestimonialModel(
          name: 'Karim Hossain',
          role: 'CTO',
          company: 'InnovateDhaka',
          comment:
              'Great communicator, very professional, and delivers exactly what '
              'he promises. Will work with Siam again for sure.',
          rating: 4.5,
        ),
      ];

  List<ServiceModel> get services => [
        const ServiceModel(
          title: 'Flutter App Development',
          description:
              'End-to-end Flutter applications for Android, iOS, and Web '
              'with clean architecture and GetX.',
          icon: Icons.phone_android_rounded,
        ),
        const ServiceModel(
          title: 'UI/UX Implementation',
          description:
              'Pixel-perfect implementation of Figma/Adobe XD designs with '
              'smooth animations and micro-interactions.',
          icon: Icons.design_services_rounded,
        ),
        const ServiceModel(
          title: 'API Integration',
          description:
              'Seamless REST and GraphQL API integration with proper error '
              'handling, caching, and offline support.',
          icon: Icons.api_rounded,
        ),
        const ServiceModel(
          title: 'Firebase Integration',
          description:
              'Auth, Firestore, Cloud Functions, Storage, and Push Notifications '
              'with Flutter Firebase SDK.',
          icon: Icons.local_fire_department_rounded,
        ),
        const ServiceModel(
          title: 'Performance Optimization',
          description:
              'Profiling, lazy loading, const widgets, image caching, and '
              'rendering optimization for 60fps UIs.',
          icon: Icons.speed_rounded,
        ),
        const ServiceModel(
          title: 'Code Review & Consultation',
          description:
              'Architecture review, code quality improvements, and technical '
              'consultation for Flutter projects.',
          icon: Icons.code_rounded,
        ),
      ];

  List<AchievementModel> get achievements => [
        const AchievementModel(
          title: 'Top Freelancer',
          description: 'Ranked top 5% on Fiverr for Flutter Development',
          year: '2024',
          icon: Icons.star_rounded,
        ),
        const AchievementModel(
          title: 'Hackathon Winner',
          description:
              'First place at BDApps Innovation Challenge with Flutter app',
          year: '2023',
          icon: Icons.emoji_events_rounded,
        ),
        const AchievementModel(
          title: '50+ Projects',
          description: 'Successfully delivered 50+ Flutter projects for clients',
          year: '2024',
          icon: Icons.rocket_launch_rounded,
        ),
        const AchievementModel(
          title: 'Open Source',
          description: '200+ GitHub stars across open source Flutter packages',
          year: '2023',
          icon: Icons.people_rounded,
        ),
      ];

  List<String> get techStack => [
        'Flutter',
        'Dart',
        'GetX',
        'Firebase',
        'REST API',
        'Git',
        'GitHub',
        'SQLite',
        'Hive',
        'Figma',
        'VS Code',
        'Android Studio',
        'Postman',
        'Dio',
        'Provider',
        'Riverpod',
      ];

  List<String> get projectCategories => ['All', 'Mobile', 'Web'];
}
