import 'package:get/get.dart';

import '../controllers/testseries_controller.dart';

class TestseriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestseriesController>(
      () => TestseriesController(),
    );
  }
}
