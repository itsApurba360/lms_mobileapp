import 'package:get/get.dart';

import '../controllers/examinstructions_controller.dart';

class ExaminstructionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExaminstructionsController>(
      () => ExaminstructionsController(),
    );
  }
}
