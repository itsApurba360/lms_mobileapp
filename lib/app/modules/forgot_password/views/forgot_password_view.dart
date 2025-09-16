import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:lms_app/app/utils/widgets/custom_loading_button.dart';
import 'package:pinput/pinput.dart';

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final basePinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:
          theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    final focusedPinTheme = basePinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cs.primary, width: 2),
    );

    final submittedPinTheme = basePinTheme.copyDecorationWith(
      border: Border.all(color: cs.primaryContainer),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                      ),

                      const SizedBox(height: 24),

                      // "Forgot Password"
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 24),
                      // Email or Mobile Input
                      Obx(
                        () => TextFormField(
                          enabled: !controller.otpSent.value,
                          controller: controller.emailController,
                          cursorColor: Colors.grey.shade300,
                          decoration: InputDecoration(
                            labelText: 'Email or Mobile',
                            labelStyle: TextStyle(color: Colors.grey.shade700),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1.5),
                            ),
                            floatingLabelStyle:
                                TextStyle(color: Colors.grey.shade700),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Field cannot be empty';
                            }
                            if (!validateEmailOrMobile(value.trim())) {
                              return 'Enter a valid email or mobile number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),

                      Obx(() {
                        if (controller.otpSent.value) {
                          return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  'Please enter the OTP to continue',
                                ),
                                const SizedBox(height: 12),
                                Pinput(
                                  controller: controller.otpController,
                                  length: 4,
                                  defaultPinTheme: basePinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  separatorBuilder: (index) =>
                                      const SizedBox(width: 10),
                                  validator: (value) =>
                                      value?.length != 4 ? 'Invalid OTP' : null,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: controller.newPasswordController,
                                  cursorColor: Colors.grey.shade300,
                                  decoration: InputDecoration(
                                    labelText: 'New Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade700),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.5),
                                    ),
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller:
                                      controller.confirmPasswordController,
                                  cursorColor: Colors.grey.shade300,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle:
                                        TextStyle(color: Colors.grey.shade700),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.5),
                                    ),
                                    floatingLabelStyle:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Field cannot be empty';
                                    }
                                    if (controller.newPasswordController.text
                                            .trim() !=
                                        value.trim()) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),

                      const SizedBox(height: 16),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: Obx(
                          () => CustomLoadingButton(
                            onPressed: () async {
                              if (controller.otpSent.value) {
                                await controller.verifyOtpAndUpdatePassword();
                              } else {
                                await controller.forgotPassword();
                              }
                            },
                            text: controller.otpSent.value
                                ? 'Verify OTP'
                                : 'Submit',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
