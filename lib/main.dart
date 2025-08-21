import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ApiClientController(), permanent: true);
        },
      ),
      getPages: AppPages.routes,
    ),
  );
}
