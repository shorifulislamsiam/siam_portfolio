import 'package:get/get.dart';
import 'package:siam_portfolio/core/controllers/theme_controller.dart';

/// Global controller bindings.
/// All controllers registered here are available app-wide from startup.
class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Theme controller — available globally
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
  }
}
