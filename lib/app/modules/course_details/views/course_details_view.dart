import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/course_details/controllers/course_details_controller.dart';
import 'package:lms_app/app/utils/helpers.dart';
import 'package:omni_video_player/omni_video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CourseDetailsView extends GetView<CourseDetailsController> {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // handle cart action
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // handle share action
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: RefreshIndicator(
          onRefresh: () => controller.fetchCourseDetails(),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: double.infinity,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Obx(() {
                                if (controller.loadPlayer.value) {
                                  return VisibilityDetector(
                                    key: const Key('video-player-visibility'),
                                    onVisibilityChanged: (visibilityInfo) {
                                      controller
                                          .onVisibilityChanged(visibilityInfo);
                                    },
                                    child: OmniVideoPlayer(
                                      callbacks: VideoPlayerCallbacks(
                                        onControllerCreated:
                                            (playerController) {
                                          controller.videoPlaybackController
                                              .setController(playerController);
          
                                          // if the widget is visible to the screen it should start playing
                                          if (controller
                                              .isPlayerVisible.value) {
                                            controller.videoPlaybackController
                                                .omniVideoPlaybackController
                                                ?.play();
                                          }
                                        },
                                      ),
                                      options: videoPlayerConfig(),
                                    ),
                                  );
                                }
          
                                final thumbUrl = getYouTubeThumbnail(
                                    controller.course.value.videoLink);
                                return InkWell(
                                  onTap: () {
                                    if (controller.youtubeUri != null) {
                                      controller.loadPlayer.value = true;
                                    } else {
                                      Get.snackbar('Video unavailable',
                                          'Invalid or missing YouTube link');
                                    }
                                  },
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      if (thumbUrl.isNotEmpty)
                                        CachedNetworkImage(
                                          imageUrl: thumbUrl,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) =>
                                              Container(color: Colors.black12),
                                        )
                                      else
                                        Container(color: Colors.black12),
                                      Center(
                                        child: Container(
                                          width: 64,
                                          height: 64,
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.play_arrow,
                                              color: Colors.white, size: 36),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                controller.course.value.category ?? "",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 9, 115, 12),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.course.value.title!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                                controller.coursesController
                                    .getCoursePrice(controller.course.value),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            if (controller.hasDiscount.value)
                              Text(
                                controller.course.value.customDiscountedPrice
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            SizedBox(width: 4),
                            Text(
                              "${controller.course.value.customCourseDuration?.toInt() ?? 0} hours",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 58, 58, 58),
                                  fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.circle,
                                  size: 6, color: Colors.grey),
                            ),
                            SizedBox(width: 4),
                            Obx(() => Text(
                                "${controller.courseOutline.length} Lessons",
                                style: TextStyle(
                                    color: Color.fromARGB(221, 58, 58, 58),
                                    fontSize: 14))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          labelColor: Colors.green,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.green,
                          tabs: [
                            Tab(text: "Info"),
                            Tab(text: "Chapters"),
                            Tab(text: "Resources"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                // TAB 1: Info Tab
                _buildInfoTab(),
                // TAB 2: Chapters Tab
                Obx(
                  () => controller.courseOutline.isEmpty
                      ? const Center(child: Text('No chapters found'))
                      : ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                              16, 16, 16, kBottomNavigationBarHeight + 24),
                          itemCount: controller.courseOutline.length,
                          itemBuilder: (context, chapterIndex) {
                            final chapter =
                                controller.courseOutline[chapterIndex];
                            final lessons = chapter.lessons;
                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          chapter.title ?? '',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    if (lessons != null && lessons.isNotEmpty)
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: lessons.length,
                                        itemBuilder: (context, lessonIndex) {
                                          final lesson = lessons[lessonIndex];
                                          return ListTile(
                                            visualDensity:
                                                VisualDensity.compact,
                                            enabled: true,
                                            title: Text(lesson.title ?? ''),
                                            subtitle: lesson.body != null
                                                ? Text(lesson.body ?? '')
                                                : null,
                                            trailing: IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              icon: Icon(
                                                lesson.includeInPreview == 1
                                                    ? Icons.play_arrow
                                                    : Icons.lock,
                                                color:
                                                    lesson.includeInPreview == 1
                                                        ? Colors.green
                                                        : Colors.grey,
                                              ),
                                              onPressed: () {
                                                if (lesson.includeInPreview ==
                                                    1) {
                                                  controller.playLesson(lesson);
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                // TAB 3: Resources Tab (placeholder)
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: AutoSizeText(
                    controller.coursesController
                        .getCoursePrice(controller.course.value),
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 12, 20, kBottomNavigationBarHeight + 24),
      child: Html(
        data: controller.course.value.description,
        style: {
          'body': Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
            color: Colors.black87,
            lineHeight: LineHeight.number(1.5),
            fontSize: FontSize(15.0),
          ),
          'p': Style(
            margin: Margins.only(top: 0, bottom: 8),
            padding: HtmlPaddings.zero,
          ),
          'span': Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          'strong': Style(fontWeight: FontWeight.w600),
          'b': Style(fontWeight: FontWeight.w600),
          'em': Style(fontStyle: FontStyle.italic),
          'ul': Style(
            margin: Margins.only(top: 4, bottom: 8),
            padding: HtmlPaddings.only(left: 18),
            listStyleType: ListStyleType.disc,
            listStylePosition: ListStylePosition.outside,
          ),
          'ol': Style(
            margin: Margins.only(top: 4, bottom: 8),
            padding: HtmlPaddings.only(left: 20),
            listStyleType: ListStyleType.decimal,
            listStylePosition: ListStylePosition.outside,
          ),
          'li': Style(
            margin: Margins.only(bottom: 6),
            padding: HtmlPaddings.zero,
            lineHeight: LineHeight.number(1.5),
          ),
          'h1': Style(
              margin: Margins.only(bottom: 8),
              fontSize: FontSize(22.0),
              fontWeight: FontWeight.w700),
          'h2': Style(
              margin: Margins.only(bottom: 8),
              fontSize: FontSize(20.0),
              fontWeight: FontWeight.w700),
          'h3': Style(
              margin: Margins.only(bottom: 6),
              fontSize: FontSize(18.0),
              fontWeight: FontWeight.w700),
        },
      ),
    );
  }

  VideoPlayerConfiguration videoPlayerConfig() {
    return VideoPlayerConfiguration(
      globalPlaybackControlSettings: GlobalPlaybackControlSettings(
        useGlobalPlaybackController: false,
      ),
      videoSourceConfiguration: !controller.isLessonVideo.value
          ? VideoSourceConfiguration.youtube(
              enableYoutubeWebViewFallback: true,
              videoUrl: controller.youtubeUri ??
                  Uri.parse('https://www.youtube.com/watch?v='),
              forceYoutubeWebViewOnly: true,
              preferredQualities: [
                OmniVideoQuality.high720,
                OmniVideoQuality.low144,
              ],
              availableQualities: [
                OmniVideoQuality.high1080,
                OmniVideoQuality.high720,
                OmniVideoQuality.low144,
              ],
            )
          : VideoSourceConfiguration.vimeo(
              videoId: controller.getVimeoId(controller.currentLessonDetail
                  .value.customLessonVideos!.first.videoLink),
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
