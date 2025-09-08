import 'package:get/get.dart';
import 'package:lms_app/app/controllers/user_details_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(UserDetailsController(), permanent: true);
  }
}
