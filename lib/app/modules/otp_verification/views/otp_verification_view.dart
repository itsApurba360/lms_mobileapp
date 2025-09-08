import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms_app/app/modules/otp_verification/controllers/otp_verification_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import 'package:pinput/pinput.dart';



class OtpVerificationView extends GetView<OtpVerificationController> {
  const OtpVerificationView({super.key});
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
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: cs.shadow.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );

    final focusedPinTheme = basePinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cs.primary, width: 2),
    );

    final submittedPinTheme = basePinTheme.copyDecorationWith(
      color: cs.primaryContainer.withValues(alpha: 0.4),
      border: Border.all(color: cs.primaryContainer),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              cs.primaryContainer.withValues(alpha: 0.25),
              cs.secondaryContainer.withValues(alpha: 0.15),
              cs.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cs.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_user_rounded,
                          color: cs.primary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Verification',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Enter the 4-digit codes sent to your mobile number and email address.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () {
                      final bothVerified =
                          controller.mobileVerificationSuccess.value &&
                              controller.emailVerificationSuccess.value;
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: cs.surface,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 22),
                          child: bothVerified
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.celebration_rounded,
                                            color: Colors.green, size: 24),
                                        SizedBox(width: 8),
                                        Text('All set! Verification complete'),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Your mobile number and email have been verified successfully.',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: cs.onSurfaceVariant),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 12),
                                            backgroundColor: cs.primary,
                                            foregroundColor: cs.onPrimary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          onPressed: () {
                                            Get.offAllNamed(Routes.HOME);
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.home_rounded,
                                                  size: 18),
                                              SizedBox(width: 8),
                                              Text('Go to Home'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // Mobile
                                    Row(
                                      children: [
                                        Icon(Icons.phone_iphone_rounded,
                                            color: cs.primary),
                                        const SizedBox(width: 8),
                                        Text('Mobile verification',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        const Spacer(),
                                        if (controller
                                            .mobileVerificationSuccess.value)
                                          Chip(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            labelPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.green
                                                .withValues(alpha: 0.12),
                                            side: BorderSide.none,
                                            visualDensity:
                                                VisualDensity.compact,
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 18),
                                                SizedBox(width: 4),
                                                Text('Verified'),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.mobileNo.value,
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: cs.onSurfaceVariant),
                                    ),
                                    const SizedBox(height: 12),
                                    Pinput(
                                      enabled: !controller
                                          .mobileVerificationSuccess.value,
                                      controller:
                                          controller.mobileOtpController,
                                      length: 4,
                                      defaultPinTheme: basePinTheme,
                                      focusedPinTheme: focusedPinTheme,
                                      submittedPinTheme: submittedPinTheme,
                                      separatorBuilder: (index) =>
                                          const SizedBox(width: 10),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 12),
                                            backgroundColor: (controller
                                                        .isVerifyingMobile
                                                        .value ||
                                                    controller
                                                        .mobileVerificationSuccess
                                                        .value)
                                                ? cs.primary
                                                    .withValues(alpha: 0.3)
                                                : cs.primary,
                                            foregroundColor: cs.onPrimary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          onPressed: (controller
                                                      .isVerifyingMobile
                                                      .value ||
                                                  controller
                                                      .mobileVerificationSuccess
                                                      .value)
                                              ? null
                                              : () async {
                                                  await controller
                                                      .verifyMobileOtp();
                                                },
                                          child: controller
                                                  .isVerifyingMobile.value
                                              ? SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            cs.onPrimary),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Icon(Icons.verified_rounded,
                                                        size: 18),
                                                    SizedBox(width: 8),
                                                    Text('Verify Mobile'),
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(height: 12),
                                    Divider(
                                        color: cs.outlineVariant
                                            .withValues(alpha: 0.6)),
                                    const SizedBox(height: 12),

                                    // Email
                                    Row(
                                      children: [
                                        Icon(Icons.alternate_email_rounded,
                                            color: cs.primary),
                                        const SizedBox(width: 8),
                                        Text('Email verification',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        const Spacer(),
                                        if (controller
                                            .emailVerificationSuccess.value)
                                          Chip(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            labelPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.green
                                                .withValues(alpha: 0.12),
                                            side: BorderSide.none,
                                            visualDensity:
                                                VisualDensity.compact,
                                            label: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: const [
                                                Icon(Icons.check_circle,
                                                    color: Colors.green,
                                                    size: 18),
                                                SizedBox(width: 4),
                                                Text('Verified'),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.email.value,
                                      textAlign: TextAlign.left,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: cs.onSurfaceVariant),
                                    ),
                                    const SizedBox(height: 12),
                                    Pinput(
                                      enabled: !controller
                                          .emailVerificationSuccess.value,
                                      controller: controller.emailOtpController,
                                      length: 4,
                                      defaultPinTheme: basePinTheme,
                                      focusedPinTheme: focusedPinTheme,
                                      submittedPinTheme: submittedPinTheme,
                                      separatorBuilder: (index) =>
                                          const SizedBox(width: 10),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 12),
                                            backgroundColor: (controller
                                                        .isVerifyingEmail
                                                        .value ||
                                                    controller
                                                        .emailVerificationSuccess
                                                        .value)
                                                ? cs.primary
                                                    .withValues(alpha: 0.3)
                                                : cs.primary,
                                            foregroundColor: cs.onPrimary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          onPressed: (controller
                                                      .isVerifyingEmail.value ||
                                                  controller
                                                      .emailVerificationSuccess
                                                      .value)
                                              ? null
                                              : () async {
                                                  await controller
                                                      .verifyEmailOtp();
                                                },
                                          child: controller
                                                  .isVerifyingEmail.value
                                              ? SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            cs.onPrimary),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Icon(Icons.verified_rounded,
                                                        size: 18),
                                                    SizedBox(width: 8),
                                                    Text('Verify Email'),
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
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

