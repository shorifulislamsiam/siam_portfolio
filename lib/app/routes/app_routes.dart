import 'package:get/get.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';
import 'package:siam_portfolio/feature/Splash_screen/presentation/screen/splash_screen.dart';
import 'package:siam_portfolio/feature/home/bindings/home_binding.dart';
import 'package:siam_portfolio/feature/home/views/home_screen.dart';
import 'package:siam_portfolio/feature/not_found/views/not_found_screen.dart';
import 'package:siam_portfolio/feature/project_detail/bindings/project_detail_binding.dart';
import 'package:siam_portfolio/feature/project_detail/views/project_detail_screen.dart';


/// GetX page route configuration.
class AppRoutes {
  AppRoutes._();

  /// List of all GetPage routes.
  static final List<GetPage> pages = [
    GetPage(
      name: AppStringRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppStringRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppStringRoutes.projectDetail,
      page: () => const ProjectDetailScreen(),
      binding: ProjectDetailBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppStringRoutes.notFound,
      page: () => const NotFoundScreen(),
    ),
  ];

  /// Fallback route for unknown URLs.
  static final GetPage notFoundPage = GetPage(
    name: AppStringRoutes.notFound,
    page: () => const NotFoundScreen(),
  );
}