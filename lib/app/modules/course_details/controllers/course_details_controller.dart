import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:omni_video_player/omni_video_player.dart';

class CourseDetailsController extends GetxController with StateMixin {
  late OmniPlaybackController playbackController;
  final course = Course().obs;

  @override
  void onInit() {
    super.onInit();
    course.value = Get.arguments['course'];
    log(course.value.videoLink!, name: 'videoLink');
    change(null, status: RxStatus.success());
  }

  @override
  void onClose() {
    playbackController.dispose();
    super.onClose();
  }

  /// Returns a sanitized YouTube watch URL built from the API's videoLink.
  /// Supports raw IDs (optionally with query like `?si=...`), youtu.be links,
  /// youtube.com/watch URLs, /shorts/, and /embed/ formats.
  Uri? get youtubeUri {
    final uri = buildYouTubeWatchUri(course.value.videoLink);
    if (uri != null) {
      log(uri.toString(), name: 'youtubeUrl');
    }
    return uri;
  }

}
