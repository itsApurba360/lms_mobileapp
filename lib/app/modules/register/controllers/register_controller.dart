import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/global_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final studentNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  final apiClientController = Get.find<ApiClientController>();
  final globalController = Get.find<GlobalController>();

  Future newRegistration() async {
    if (!formKey.currentState!.validate()) return;
    final response = await apiClientController.newRegistration(
      studentName: studentNameController.text.trim(),
      email: emailController.text.trim(),
      mobileNo: mobileNoController.text.trim(),
      password: passwordController.text.trim(),
      hostUrl: globalController.baseUrl.value,
    );

    if (response.statusCode == 200) {
      Get.toNamed(Routes.OTP_VERIFICATION, arguments: {
        'email': emailController.text.trim(),
        'mobileNo': mobileNoController.text.trim(),
      });
    }
  }
}
