import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_login_controller.dart';

class OtpLoginView extends StatelessWidget {
  final controller = Get.put(OtpLoginController());

  OtpLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: Column(
                key: ValueKey(controller.isOtpSent.value),
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.isOtpSent.value
                          ? "Enter OTP sent to "
                          : "Enter mobile number to continue",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),

                  if (controller.isOtpSent.value)
                    Text(
                      controller.mobileNumber.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),

                  const SizedBox(height: 16),

                  // Input Field or OTP Fields
                  controller.isOtpSent.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (index) {
                            return SizedBox(
                              width: 60,
                              child: TextField(
                                controller: controller.otpControllers[index],
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                onChanged: (value) {
                                  if (value.isNotEmpty && index < 3) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade400,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        )
                      : TextField(
                          controller: controller.mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Colors.grey[700]),
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
                        ),

                  const SizedBox(height: 4),

                  // Bottom Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.isOtpSent.value)
                        const SizedBox.shrink()
                      else
                        const SizedBox.shrink(),
                      if (controller.isOtpSent.value)
                        Obx(() => TextButton(
                              onPressed: controller.resendCountdown.value == 0
                                  ? controller.resendOtp
                                  : null,
                              child: Text(
                                controller.resendCountdown.value == 0
                                    ? "Resend OTP"
                                    : "Resend OTP in ${controller.resendCountdown.value}s",
                                style: TextStyle(
                                  color: controller.resendCountdown.value == 0
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ))
                      else
                        const SizedBox.shrink(),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Send OTP or Confirm OTP button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isOtpSent.value
                          ? controller.confirmOtp
                          : controller.sendOtp,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.isOtpSent.value ? 'Confirm OTP' : 'Send OTP',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Back Button Below Confirm OTP
                  if (controller.isOtpSent.value)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: controller.backToMobileInput,
                          icon: const Icon(Icons.arrow_back,
                              size: 16, color: Colors.grey),
                          label: const Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Login with Email bottom-right
                  if (!controller.isOtpSent.value)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.back(); // or navigate to LoginView()
                        },
                        child: const Text(
                          "Login with Email",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
