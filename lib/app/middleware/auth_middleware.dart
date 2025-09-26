import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';
// import removed to avoid circular dependency with app_pages.dart

/// Middleware that prevents authenticated users from accessing auth pages
class RedirectAuthenticatedToHome extends GetMiddleware {
  RedirectAuthenticatedToHome();

  @override
  RouteSettings? redirect(String? route) {
    try {
      final api = Get.find<ApiClientController>();
      final hasHost = (api.hostUrl ?? '').isNotEmpty;
      final hasCookies = (api.cookies ?? '').isNotEmpty;
      if (hasHost && hasCookies) {
        // User appears authenticated; send them to Home
        return const RouteSettings(name: Routes.HOME);
      }
    } catch (_) {
      // If controller isn't available yet, allow navigation to proceed
    }
    return null;
  }
}
