import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ApiClientController(), permanent: true);
        },
      ),
      theme: ThemeData(
          // leading: IconButton(
          //   icon: const Icon(Icons.menu_open),
          //   onPressed: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          // ),
          ),
      getPages: AppPages.routes,
    ),
  );
}
