import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import 'package:lms_app/app/utils/helpers.dart';

class ForgotPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final hostUrlController =
      TextEditingController(text: 'http://192.168.1.157:8004');
  final apiClientController = Get.find<ApiClientController>();
  final otpSent = false.obs;

  Future<void> forgotPassword() async {
    if (formKey.currentState!.validate()) {
      final isEmail = isValidEmail(emailController.text.trim());
      var body = {};
      if (isEmail) {
        body = {"email": emailController.text.trim()};
      } else {
        body = {"mobile_no": emailController.text.trim()};
      }
      final response = await apiClientController.forgotPassword(
          hostUrl: hostUrlController.text.trim(), data: body);
      if (response.statusCode == 200) {
        otpSent.value = true;
      }
    }
  }

  Future<void> verifyOtpAndUpdatePassword() async {
    if (formKey.currentState!.validate()) {
      final isEmail = isValidEmail(emailController.text.trim());
      var body = {};
      if (isEmail) {
        body = {"email": emailController.text.trim()};
      } else {
        body = {"mobile_no": emailController.text.trim()};
      }
      body["otp"] = otpController.text.trim();
      body["password"] = newPasswordController.text.trim();
      final response = await apiClientController.post(
          "/api/method/lms_360ithub.api.verify_otp_and_change_password",
          data: body);
      if (response.statusCode == 200) {
        // Get.snackbar("Success",
        //     "Password updated successfully! Please use new password to login",
        //     backgroundColor: Theme.of(Get.context!).colorScheme.primary);
        // Get.toNamed(Routes.LOGIN);
      }
    }
  }
}
