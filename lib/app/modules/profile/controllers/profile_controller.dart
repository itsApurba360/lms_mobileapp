import 'package:get/get.dart';
import 'package:lms_app/app/controllers/user_details_controller.dart';
import 'package:lms_app/app/models/user_details.dart';

class ProfileController extends GetxController {
  
  final _userDetailsController = Get.find<UserDetailsController>();

  UserDetails get userDetails => _userDetailsController.userDetails.value;

}
