import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // Email and Password text controllers
  final hostUrlController = TextEditingController(
    text: 'http://192.168.1.157:8004',
  );
  final emailController = TextEditingController(
    // text: 'mohan.ra@360ithub.co.in',
    text: '90985430401',
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

  // Unified login: accepts either email or mobile number and routes to the right API
  Future login() async {
    final identifier = emailController.text.trim();
    final password = passwordController.text.trim();

    if (identifier.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email/Mobile and password cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final isEmail = emailRegex.hasMatch(identifier);
    // Accept 8-15 digits with optional leading + for international numbers
    final isMobile = !isEmail && RegExp(r'^\+?\d{8,15}$').hasMatch(identifier);

    bool success = false;

    if (isEmail) {
      success = await apiClientController.loginWithEmailPassword(
        hostUrlController.text,
        identifier,
        password,
      );
    } else if (isMobile) {
      success = await apiClientController.loginWithMobilePassword(
        hostUrlController.text,
        identifier,
        password,
      );
    } else {
      Get.snackbar(
        "Invalid input",
        "Please enter a valid email address or mobile number",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

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
