import 'package:get/get.dart';
import 'package:omni_video_player/omni_video_player/controllers/omni_playback_controller.dart';

class VideoPlaybackController extends GetxController {
  OmniPlaybackController? omniVideoPlaybackController;

  void setController(OmniPlaybackController controller) {
    omniVideoPlaybackController = controller;
  }

  void clearController() {
    if (omniVideoPlaybackController != null && omniVideoPlaybackController?.isBlank != true) {
      omniVideoPlaybackController?.dispose();
    }
  }
}
