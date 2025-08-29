import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:omni_video_player/omni_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../controllers/course_lesson_controller.dart';

class CourseLessonView extends GetView<CourseLessonController> {
  const CourseLessonView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Viewer'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => ListView(
          children: [
            if (controller.lesson.value.customLessonVideos?.isNotEmpty ?? false)
              Container(
                // margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: VisibilityDetector(
                  key: const Key('video-player-visibility'),
                  onVisibilityChanged: (visibilityInfo) {
                    controller.onVisibilityChanged(visibilityInfo);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: OmniVideoPlayer(
                        key: ValueKey<String>(
                          'vimeo-${getVimeoId(controller.lesson.value.customLessonVideos!.first.videoLink)}',
                        ),
                        callbacks: VideoPlayerCallbacks(
                          onControllerCreated: (playerController) {
                            controller.videoPlaybackController
                                .setController(playerController);

                            if (controller.isPlayerVisible.value) {
                              controller.videoPlaybackController
                                  .omniVideoPlaybackController
                                  ?.play();
                            }
                          },
                        ),
                        options: videoPlayerConfig(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  VideoPlayerConfiguration videoPlayerConfig() {
    return VideoPlayerConfiguration(
      globalPlaybackControlSettings: GlobalPlaybackControlSettings(
        useGlobalPlaybackController: false,
      ),
      videoSourceConfiguration: VideoSourceConfiguration.vimeo(
        videoId: getVimeoId(
            controller.lesson.value.customLessonVideos!.first.videoLink),
      ),
      playerTheme: OmniVideoPlayerThemeData().copyWith(
        icons: VideoPlayerIconTheme().copyWith(error: Icons.warning),
        overlays: VideoPlayerOverlayTheme().copyWith(
          backgroundColor: Colors.transparent,
          alpha: 0,
        ),
      ),
      playerUIVisibilityOptions: PlayerUIVisibilityOptions(
        showMuteUnMuteButton: true,
        showFullScreenButton: true,
        useSafeAreaForBottomControls: true,
        showErrorPlaceholder: false,
        showThumbnailAtStart: false,
      ),
      customPlayerWidgets: CustomPlayerWidgets().copyWith(
        thumbnailFit: BoxFit.cover,
      ),
    );
  }
}
