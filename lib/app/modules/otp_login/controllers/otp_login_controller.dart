import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpLoginController extends GetxController {
  final mobileController = TextEditingController();
  final otpControllers = List.generate(4, (_) => TextEditingController());

  final isOtpSent = false.obs;
  final mobileNumber = ''.obs;

  final resendCountdown = 30.obs;
  Timer? _timer;

  void sendOtp() {
    if (mobileController.text.trim().isEmpty ||
        mobileController.text.length != 10) {
      Get.snackbar("Invalid", "Please enter a valid 10-digit mobile number");
      return;
    }

    mobileNumber.value = mobileController.text;
    isOtpSent.value = true;

    _startTimer();
    // 🔒 Here you’d call your backend to send OTP to mobileNumber.value
  }

  void confirmOtp() async {
    String otp = otpControllers.map((c) => c.text).join();
    if (otp.length < 4) {
      Get.snackbar("Invalid", "Please enter complete 4-digit OTP");
      return;
    }

    // Show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // 🔐 Call your backend to verify OTP
      print("Confirming OTP: $otp for ${mobileNumber.value}");

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Close loading dialog
      Get.back();

      // Navigate to home screen on success
      Get.offAllNamed('/home');
    } catch (e) {
      // Close loading dialog if still open
      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar("Error", "Failed to verify OTP. Please try again.");
    }
  }

  void backToMobileInput() {
    isOtpSent.value = false;
    _cancelTimer();
    resendCountdown.value = 30;
    otpControllers.forEach((c) => c.clear());
  }

  void _startTimer() {
    _cancelTimer();
    resendCountdown.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        _cancelTimer();
      }
    });
  }

  void resendOtp() {
    if (resendCountdown.value == 0) {
      sendOtp();
    }
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    mobileController.dispose();
    otpControllers.forEach((c) => c.dispose());
    _cancelTimer();
    super.onClose();
  }
}
