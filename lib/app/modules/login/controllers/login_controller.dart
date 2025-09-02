import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Email and Password text controllers
  final hostUrlController = TextEditingController(
    text: 'http://192.168.1.152:8004',
  );
  final emailController = TextEditingController(
    text: 'mohan.ra@360ithub.co.in',
  );
  final passwordController = TextEditingController(
    text: 'India@123#',
  );

  final apiClientController = Get.find<ApiClientController>();

  // Observable for toggling password visibility
  RxBool obscurePassword = true.obs;

  // Email validation regex
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

  // Login action
  Future loginWithEmailPassword() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final success = await apiClientController.loginWithEmailPassword(
        hostUrlController.text, email, password);

    if (success) Get.offAllNamed(Routes.HOME);
  }

  // Clean up controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
