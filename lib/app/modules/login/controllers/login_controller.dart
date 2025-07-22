import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Email and Password text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable for toggling password visibility
  RxBool obscurePassword = true.obs;

  // Email validation regex
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');

  // Login action
  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

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

    // 🚀 Add your API call or auth logic here
    print("Logging in with: $email / $password");

    // Simulate success
    Get.snackbar("Success", "Logged in successfully!",
        snackPosition: SnackPosition.BOTTOM);
  }

  // Clean up controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
