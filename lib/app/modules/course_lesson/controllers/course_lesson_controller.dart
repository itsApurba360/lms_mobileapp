import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/video_playback_controller.dart';
import 'package:lms_app/app/models/attachment.dart';
import 'package:lms_app/app/models/lesson_detail.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CourseLessonController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  final lesson = LessonDetail().obs;
  final videoPlaybackController = Get.find<VideoPlaybackController>();
  final RxBool isPlayerVisible = false.obs;
  final apiClientController = Get.find<ApiClientController>();

  final lessonResources = <Attachment>[].obs;
  late TabController tabController;
  final currentTabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    lesson.value = Get.arguments['lesson'];
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
    getLessonResources();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onVisibilityChanged(VisibilityInfo info) {
    log(info.visibleFraction.toString(), name: 'visibleFraction');
    isPlayerVisible.value = info.visibleFraction > 0.8;
    log(isPlayerVisible.value.toString(), name: 'isPlayerVisible');
  }

  Future<void> getLessonResources() async {
    try {
      final response = await apiClientController.post(
        '/api/method/lms_360ithub.api.get_lesson_resources',
        data: {'lesson': lesson.value.name!},
      );
      lessonResources.value =
          AttachmentResponse.fromJson(response.data).message ?? [];
      change(null, status: RxStatus.success());
    } catch (e) {
      log(e.toString(), name: 'getLessonResourcesError');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> downloadAndOpenResource(
    String? fileUrl,
    String? fileName,
  ) async {
    if (fileUrl == null || fileName == null) {
      Get.snackbar(
        'Error',
        'Invalid file information',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    try {
      // Show loading indicator using GetX overlay
      Get.dialog(
        const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        barrierDismissible: false,
      );

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/$fileName';

      // Check if file already exists
      final file = File(filePath);
      if (await file.exists()) {
        Get.back(); // Close loading dialog
        await OpenFilex.open(filePath);
        return;
      }

      // Download file using Dio
      final response = await apiClientController.dio.download(
        fileUrl,
        filePath,
        onReceiveProgress: (received, total) {
          // Optional: Add progress indicator if needed
        },
      );

      if (response.statusCode == 200) {
        Get.back(); // Close loading dialog
        await OpenFilex.open(filePath);
      } else {
        Get.back(); // Close loading dialog
        Get.snackbar(
          'Error',
          'Failed to download file: ${response.statusCode}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar(
        'Error',
        'Failed to download file: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
