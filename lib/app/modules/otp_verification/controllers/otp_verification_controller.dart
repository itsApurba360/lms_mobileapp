import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';

class OtpVerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final mobileOtpController = TextEditingController();
  final emailOtpController = TextEditingController();
  final mobileNo = ''.obs;
  final email = ''.obs;
  final apiClientController = Get.find<ApiClientController>();
  final mobileVerificationSuccess = false.obs;
  final emailVerificationSuccess = false.obs;
  // Loading states
  final isVerifyingMobile = false.obs;
  final isVerifyingEmail = false.obs;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.arguments['email'];
    mobileNo.value = Get.arguments['mobileNo'];
  }

  Future verifyMobileOtp() async {
    if (isVerifyingMobile.value || mobileVerificationSuccess.value) return;
    isVerifyingMobile.value = true;
    try {
      final response = await apiClientController.post(
        '/api/method/lms_360ithub.utils.custom_login.registration_verification',
        data: {
          'verification_type': 'mobile',
          'identifier': mobileNo.value,
          'otp': mobileOtpController.text,
        },
      );
      if (response.statusCode == 200) {
        mobileVerificationSuccess.value = true;
        Get.snackbar('Success', 'Mobile OTP verified successfully',
            backgroundColor: Theme.of(Get.context!).colorScheme.primary,
            colorText: Theme.of(Get.context!).colorScheme.onPrimary);
      }
    } finally {
      isVerifyingMobile.value = false;
    }
  }

  Future verifyEmailOtp() async {
    if (isVerifyingEmail.value || emailVerificationSuccess.value) return;
    isVerifyingEmail.value = true;
    try {
      final response = await apiClientController.post(
        '/api/method/lms_360ithub.utils.custom_login.registration_verification',
        data: {
          'verification_type': 'email',
          'identifier': email.value,
          'otp': emailOtpController.text,
        },
      );
      if (response.statusCode == 200) {
        emailVerificationSuccess.value = true;
      }
    } finally {
      isVerifyingEmail.value = false;
    }
  }
}
