import 'package:get/get.dart';
import 'package:lms_app/app/modules/courses/controllers/courses_controller.dart';

import '../controllers/purchases_controller.dart';

class PurchasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchasesController>(
      () => PurchasesController(),
    );
    Get.put(CoursesController());
  }
}
