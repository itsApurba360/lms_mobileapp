import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
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
        title: const Text('Lesson'),
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

            // Show tab bar and tab content when lesson resources are available
            if (controller.lessonResources.isNotEmpty)
              Column(
                children: [
                  TabBar(
                    controller: controller.tabController,
                    tabs: const [
                      Tab(text: 'Info'),
                      Tab(text: 'Resources'),
                    ],
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        // Info Tab Content
                        if (controller.lesson.value.body != null &&
                            controller.lesson.value.body!.isNotEmpty)
                          SingleChildScrollView(
                            padding: const EdgeInsets.all(20.0),
                            child: GptMarkdown(
                              controller.lesson.value.body!,
                            ),
                          )
                        else
                          const Center(
                            child: Text('No information available'),
                          ),
                        // Resources Tab Content
                        ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: controller.lessonResources.length,
                          itemBuilder: (context, index) {
                            final resource = controller.lessonResources[index];
                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 12.0),
                              child: ListTile(
                                leading: Icon(Icons.insert_drive_file,
                                    color: Theme.of(context).primaryColor),
                                title: Text(
                                  resource.fileName ?? 'Resource',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '${resource.fileType ?? 'File'} • ${formatFileSize(resource.fileSize)}',
                                ),
                                trailing: Icon(Icons.download,
                                    color: Theme.of(context).primaryColor),
                                onTap: () => controller.downloadAndOpenResource(
                                  resource.fileUrl,
                                  resource.fileName,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else
            // Show the body markdown directly when no resources
            if (controller.lesson.value.body != null &&
                controller.lesson.value.body!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GptMarkdown(
                  controller.lesson.value.body!,
                ),
              ),
          ],
        ),
        onLoading: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  String formatFileSize(num? bytes) {
    if (bytes == null) return 'Unknown size';

    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var i = 0;
    var size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
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
