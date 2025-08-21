import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';

class HomeController extends GetxController {
  
  final _apiClientController = Get.find<ApiClientController>();

  // Get homepage data
  // Future<void> getHomepageData() async {
  //   try {
  //     await _apiClientController.post('');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

}
