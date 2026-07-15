import 'package:get/get.dart';
import 'package:siam_portfolio/feature/project_detail/controllers/project_detail_controller.dart';

/// Binding for Project Detail feature.
class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(() => ProjectDetailController());
  }
}
