import 'package:get/get.dart';
import 'package:siam_portfolio/app/routes/app_string_routes.dart';

/// Controller for the Splash Screen.
/// Handles the initialization timer and navigation to Home.
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToHome();
  }

  /// Navigate to Home after a 3-second splash display.
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Get.offAllNamed(AppStringRoutes.home);
  }
}
