import 'package:get/get.dart';

import '../controllers/mcq_controller.dart';

class McqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<McqController>(
      () => McqController(),
    );
  }
}
