import 'package:get/get.dart';
import 'package:siam_portfolio/core/models/project_model.dart';

/// Controller for the Project Detail page.
/// Receives the project via GetX arguments.
class ProjectDetailController extends GetxController {
  ProjectModel? project;

  @override
  void onInit() {
    super.onInit();
    project = Get.arguments as ProjectModel?;
  }
}
