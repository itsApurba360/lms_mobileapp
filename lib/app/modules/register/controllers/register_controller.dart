import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final studentNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
  final hostUrlController =
      TextEditingController(text: 'http://192.168.1.175:8004');

  final apiClientController = Get.find<ApiClientController>();

  Future newRegistration() async {
    if (!formKey.currentState!.validate()) return;
    final response = await apiClientController.newRegistration(
      studentName: studentNameController.text.trim(),
      email: emailController.text.trim(),
      mobileNo: mobileNoController.text.trim(),
      password: passwordController.text.trim(),
      hostUrl: hostUrlController.text.trim(),
    );

    if (response.statusCode == 200) {
      Get.toNamed(Routes.OTP_VERIFICATION, arguments: {
        'email': emailController.text.trim(),
        'mobileNo': mobileNoController.text.trim(),
      });
    }
  }
}
