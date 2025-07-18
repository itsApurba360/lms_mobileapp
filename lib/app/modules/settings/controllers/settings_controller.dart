import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool currentObscured = true;
  bool newObscured = true;
  bool confirmObscured = true;

  void toggleObscure(String field) {
    switch (field) {
      case 'current':
        currentObscured = !currentObscured;
        break;
      case 'new':
        newObscured = !newObscured;
        break;
      case 'confirm':
        confirmObscured = !confirmObscured;
        break;
    }
    update(); // Notify GetBuilder to rebuild UI
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
