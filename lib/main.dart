import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/video_playback_controller.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  final savedHost = (box.read<String>('host_url') ?? '').trim();
  final savedCookies = (box.read<String>('cookies') ?? '').trim();
  final initial = (savedHost.isNotEmpty && savedCookies.isNotEmpty)
      ? Routes.HOME
      : AppPages.INITIAL;
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: initial,
      initialBinding: BindingsBuilder(
        () {
          Get.put(ApiClientController(), permanent: true);
          Get.put(VideoPlaybackController(), permanent: true);
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
