import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:omni_video_player/omni_video_player.dart';

class CourseDetailsController extends GetxController with StateMixin {
  late OmniPlaybackController playbackController;
  final globalPlaybackController = GlobalPlaybackController();
  final course = Course().obs;
  final RxBool loadPlayer = false.obs;

  @override
  void onInit() {
    log("CourseDetailsController");
    super.onInit();
    course.value = Get.arguments['course'];
    log(getYouTubeThumbnail(course.value.videoLink), name: 'thumbnail');
    change(null, status: RxStatus.success());
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
