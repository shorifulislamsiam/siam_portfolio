import 'package:get/get.dart';
import 'package:siam_portfolio/feature/home/controllers/home_controller.dart';

/// Dependency injection binding for the Home feature.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
