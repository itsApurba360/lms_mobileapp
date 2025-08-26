import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/controllers/video_playback_controller.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/models/course_outline.dart';
import 'package:lms_app/app/models/lesson_detail.dart';
import 'package:lms_app/app/modules/courses/controllers/courses_controller.dart';
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

  final RxBool isLessonVideo = false.obs;


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
    change(null, status: RxStatus.success());
    fetchCourseOutline();
    fetchCourseResources();
  }

  // Fetch course resources
  Future<void> fetchCourseResources() async {
    try {
      await apiClientController.post(
        '/api/method/lms_360ithub.api.get_course_resources',
        data: {'course': course.value.name!},
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

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
      loadPlayer.value = false;
      videoPlaybackController.clearController();
      playVideo();
    } catch (e) {
      log(e.toString(), name: 'playLessonError');
      Get.snackbar('Error', e.toString());
    }
  }

  void playVideo() {
    loadPlayer.value = true;
    isLessonVideo.value = true;
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
  String getVimeoId(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      log('No videoLink provided', name: 'vimeoId');
      return '';
    }

    String value = raw.trim();
    String id = value;

    // If the value is a full Vimeo URL, extract the video ID
    if (value.startsWith('http://') || value.startsWith('https://')) {
      try {
        final uri = Uri.parse(value);
        final host = uri.host.toLowerCase();

        if (host.contains('vimeo.com')) {
          if (uri.pathSegments.isNotEmpty) {
            id = uri.pathSegments.last;
          }
        }
      } catch (_) {
        // If parsing fails, fall back to treating it as a raw ID
        id = value;
      }
    }

    log(id, name: 'vimeoId');
    return id;
  }

}
