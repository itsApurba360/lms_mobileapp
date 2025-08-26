import 'package:get/get.dart';
import 'package:omni_video_player/omni_video_player/controllers/omni_playback_controller.dart';

class VideoPlaybackController extends GetxController {
  OmniPlaybackController? omniVideoPlaybackController;

  void setController(OmniPlaybackController controller) {
    omniVideoPlaybackController = controller;
  }

  void clearController() {
    // Do NOT manually dispose the controller here. The OmniVideoPlayer widget
    // manages the lifecycle of its internal controller in its own State.
    // Disposing it while the widget subtree is still updating can cause
    // "used after being disposed" assertions in listeners.
    // Simply drop our reference; when the widget unmounts, it will dispose.
    omniVideoPlaybackController = null;
  }
}
