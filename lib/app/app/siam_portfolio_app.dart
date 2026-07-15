import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siam_portfolio/app/routes/app_routes.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';
import 'package:siam_portfolio/core/bindings/controller_binder.dart';
import 'package:siam_portfolio/core/utils/theme/theme.dart';

/// Root application widget.
/// Configures GetMaterialApp with routing, theming, and global bindings.
class SiamPortfolioApp extends StatelessWidget {
  const SiamPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Siam | Flutter Developer',
      initialBinding: ControllerBinder(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppStringRoutes.splash,
      getPages: AppRoutes.pages,
      unknownRoute: AppRoutes.notFoundPage,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
