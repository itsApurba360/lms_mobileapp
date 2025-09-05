import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Verification',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              Obx(
                () => Column(
                  children: [
                    Text('Enter Mobile OTP',
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(controller.mobileNo.value),
                    Pinput(
                      enabled: !controller.mobileVerificationSuccess.value,
                      controller: controller.mobileOtpController,
                      length: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text('Resend Mobile OTP',
                        //       style: Theme.of(context).textTheme.titleMedium),
                        // ),
                        // const SizedBox(width: 20),
                        TextButton(
                          onPressed: (controller.isVerifyingMobile.value ||
                                  controller.mobileVerificationSuccess.value)
                              ? null
                              : () async {
                                  await controller.verifyMobileOtp();
                                },
                          child: controller.isVerifyingMobile.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              : Text('Verify Mobile',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Enter Email OTP',
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(controller.email.value),
                    Pinput(
                      enabled: !controller.emailVerificationSuccess.value,
                      controller: controller.emailOtpController,
                      length: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text('Resend Email OTP',
                        //       style: Theme.of(context).textTheme.titleMedium),
                        // ),
                        // const SizedBox(width: 20),
                        TextButton(
                          onPressed: (controller.isVerifyingEmail.value ||
                                  controller.emailVerificationSuccess.value)
                              ? null
                              : () async {
                                  await controller.verifyEmailOtp();
                                },
                          child: controller.isVerifyingEmail.value
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              : Text('Verify Email',
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
