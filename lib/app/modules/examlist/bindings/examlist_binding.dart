import 'package:get/get.dart';

import '../controllers/examlist_controller.dart';

class ExamlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExamlistController>(
      () => ExamlistController(),
    );
  }
}
