import 'package:get/get.dart';

import '../controllers/chatdetails_controller.dart';

class ChatdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatdetailsController>(
      () => ChatdetailsController(),
    );
  }
}
