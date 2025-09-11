import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/user_details_controller.dart';
import 'package:lms_app/app/models/user_details.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final _userDetailsController = Get.find<UserDetailsController>();
  final _apiClientController = Get.find<ApiClientController>();

  UserDetails get userDetails => _userDetailsController.userDetails.value;

  @override
  void onInit() {
    super.onInit();
    verifyUser();
  }

  Future<void> verifyUser() async {
    try {
      await _userDetailsController.getUserDetails();
      if (userDetails.isVerified == 0) {
        await _apiClientController.logout();
        Get.offNamed(Routes.REGISTER);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Get homepage data
  // Future<void> getHomepageData() async {
  //   try {
  //     await _apiClientController.post('');
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }
}
