import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/models/user_details.dart';

class UserDetailsController extends GetxController {
  final _apiClientController = Get.find<ApiClientController>();
  final userDetails = UserDetails().obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    try {
      final response = await _apiClientController
          .post('/api/method/lms_360ithub.api.get_user_details');
      userDetails.value = UserDetails.fromJson(response.data['message']);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
