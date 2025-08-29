import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/video_playback_controller.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/models/course_outline.dart';
import 'package:lms_app/app/models/lesson_detail.dart';
import 'package:lms_app/app/modules/courses/controllers/courses_controller.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:omni_video_player/omni_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CourseDetailsController extends GetxController with StateMixin {
  final globalPlaybackController = GlobalPlaybackController();
  final course = Course().obs;
  final courseOutline = <CourseOutline>[].obs;
  final RxBool loadPlayer = false.obs;
  final RxBool hasDiscount = false.obs;
  final RxBool isPlayerVisible = false.obs;
  final RxBool isEnrolled = false.obs;

  final RxBool isLessonVideo = false.obs;

  // Key to locate the video player area for scrolling
  final GlobalKey videoPlayerKey = GlobalKey();

  final currentLessonDetail = LessonDetail().obs;

  final videoPlaybackController = Get.find<VideoPlaybackController>();

  final apiClientController = Get.find<ApiClientController>();

  final coursesController = Get.find<CoursesController>();

  @override
  void onInit() {
    super.onInit();
    course.value = Get.arguments['course'];
    log(getYouTubeThumbnail(course.value.videoLink), name: 'thumbnail');
    hasDiscount.value =
        course.value.customDiscount != null && course.value.customDiscount! > 0;
    if (course.value.membership?.member != null) {
      isEnrolled.value = true;
    }
    change(null, status: RxStatus.success());
    fetchCourseOutline();
    // fetchCourseResources();
  }

  // Fetch course resources
  // Future<void> fetchCourseResources() async {
  //   try {
  //     await apiClientController.post(
  //       '/api/method/lms_360ithub.api.get_course_resources',
  //       data: {'course': course.value.name!},
  //     );
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  // Fetch course outline
  Future<void> fetchCourseOutline() async {
    try {
      final response = await apiClientController.post(
        '/api/method/lms.lms.utils.get_course_outline',
        data: {'course': course.value.name!},
      );
      courseOutline.value =
          CourseOutlineResponse.fromJson(response.data).message ?? [];
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  playLesson(Lesson lesson) async {
    try {
      final response = await apiClientController.post(
        '/api/method/lms_360ithub.api.get_lesson_details',
        data: {'lesson': lesson.name!},
      );
      currentLessonDetail.value =
          LessonDetailResponse.fromJson(response.data).message!;
      if (isEnrolled.value) {
        Get.toNamed(Routes.COURSE_LESSON,
            arguments: {'lesson': currentLessonDetail.value});
      } else {
      loadPlayer.value = false;
      if (currentLessonDetail.value.customLessonVideos?.isNotEmpty ?? false) {
        videoPlaybackController.clearController();
        playVideo();
      } else {
        Get.snackbar('Error', 'No video found',
            colorText: Colors.white,
            backgroundColor: Theme.of(Get.context!).colorScheme.primary);
      }
      }
    } catch (e) {
      log(e.toString(), name: 'playLessonError');
      Get.snackbar('Error', e.toString());
    }
  }

  void playVideo() {
    loadPlayer.value = true;
    isLessonVideo.value = true;
  }

  // Smoothly scrolls the view to the video player area (top header)
  void scrollToVideo() {
    final ctx = videoPlayerKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  void onVisibilityChanged(VisibilityInfo info) {
    log(info.visibleFraction.toString(), name: 'visibleFraction');
    isPlayerVisible.value = info.visibleFraction > 0.8;
    log(isPlayerVisible.value.toString(), name: 'isPlayerVisible');
  }

  /// Returns a sanitized YouTube watch URL built from the API's videoLink.
  /// Supports raw IDs (optionally with query like `?si=...`), youtu.be links,
  /// youtube.com/watch URLs, /shorts/, and /embed/ formats.
  Uri? get youtubeUri {
    final raw = course.value.videoLink;
    if (raw == null || raw.trim().isEmpty) {
      log('No videoLink provided', name: 'youtubeUri');
      return null;
    }

    final uri = buildYouTubeWatchUri(raw);
    if (uri == null) {
      log('Invalid YouTube link or ID: $raw', name: 'youtubeUrlError');
      return null;
    }

    log(uri.toString(), name: 'youtubeUrl');
    return uri;
  }
}
