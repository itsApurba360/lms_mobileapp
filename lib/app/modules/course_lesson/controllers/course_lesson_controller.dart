import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/video_playback_controller.dart';
import 'package:lms_app/app/models/lesson_detail.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CourseLessonController extends GetxController with StateMixin {
  final lesson = LessonDetail().obs;
  final videoPlaybackController = Get.find<VideoPlaybackController>();
  final RxBool isPlayerVisible = false.obs;
  @override
  void onInit() {
    super.onInit();
    lesson.value = Get.arguments['lesson'];
    change(null, status: RxStatus.success());
  }

  void onVisibilityChanged(VisibilityInfo info) {
    log(info.visibleFraction.toString(), name: 'visibleFraction');
    isPlayerVisible.value = info.visibleFraction > 0.8;
    log(isPlayerVisible.value.toString(), name: 'isPlayerVisible');
  }
}
