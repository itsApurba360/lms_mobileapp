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
    // const bodyGrey = Color.fromARGB(255, 244, 244, 244);

    // // 💥 Dynamically fix expansion state length
    // if (isChapterExpanded.length != chapters.length) {
    //   isChapterExpanded = List.generate(chapters.length, (index) => false);
    // }
    return Scaffold(
        // backgroundColor: bodyGrey,
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
        body: controller.obx(
          (state) => DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                                .play();
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
                                      // Thumbnail image
                                      if (thumbUrl.isNotEmpty)
                                        CachedNetworkImage(
                                          imageUrl: thumbUrl,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) =>
                                              Container(color: Colors.black12),
                                        )
                                      else
                                        Container(color: Colors.black12),
                                      // Play button overlay
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
                                "₹999",
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
                        children: const [
                          SizedBox(width: 4),
                          Text("4h 20m",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 58, 58, 58),
                                  fontSize: 14)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child:
                                Icon(Icons.circle, size: 6, color: Colors.grey),
                          ),
                          SizedBox(width: 4),
                          Text("4 Lessons",
                              style: TextStyle(
                                  color: Color.fromARGB(221, 58, 58, 58),
                                  fontSize: 14)),
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
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
                        margin: Margins.only(bottom: 8),
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
                        margin: Margins.only(top: 4, bottom: 8, left: 16),
                        padding: HtmlPaddings.zero,
                        listStylePosition: ListStylePosition.outside,
                      ),
                      'ol': Style(
                        margin: Margins.only(top: 4, bottom: 8, left: 16),
                        padding: HtmlPaddings.zero,
                        listStylePosition: ListStylePosition.outside,
                      ),
                      'li': Style(
                        margin: Margins.only(bottom: 4),
                        padding: HtmlPaddings.zero,
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
                ),
                SizedBox(),
                SizedBox(),

                // TAB 2: Chapters Tab (with RangeError fix)
                // ListView.builder(
                //   padding: const EdgeInsets.all(16),
                //   itemCount: chapters.length,
                //   itemBuilder: (context, chapterIndex) {
                //     final chapter = chapters[chapterIndex];
                //     final lessons = chapter['lessons'] as List<dynamic>;
                //     final bool isExpanded =
                //         isChapterExpanded[chapterIndex] == true;
                  //   padding: const EdgeInsets.all(16),
                  //   itemCount: chapters.length,
                  //   itemBuilder: (context, chapterIndex) {
                  //     final chapter = chapters[chapterIndex];
                  //     final lessons = chapter['lessons'] as List<dynamic>;
                  //     final bool isExpanded =
                  //         isChapterExpanded[chapterIndex] == true;

                  //     return GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           isChapterExpanded[chapterIndex] = !isExpanded;
                  //         });
                  //       },
                  //       child: Container(
                  //         margin: const EdgeInsets.only(bottom: 12),
                  //         padding: const EdgeInsets.all(12),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(color: Colors.grey.shade200),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Row(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   (chapterIndex + 1).toString().padLeft(2, '0'),
                  //                   style: const TextStyle(
                  //                     fontSize: 20,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(width: 12),
                  //                 Expanded(
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text(
                  //                         chapter['title'],
                  //                         maxLines: 2,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: const TextStyle(
                  //                           fontSize: 16,
                  //                           fontWeight: FontWeight.w600,
                  //                         ),
                  //                       ),
                  //                       if (!isExpanded)
                  //                         Padding(
                  //                           padding: const EdgeInsets.only(top: 2),
                  //                           child: Text(
                  //                             '${lessons.length > 5 ? 5 : lessons.length} lessons',
                  //                             style: TextStyle(
                  //                                 color: Colors.grey[600]),
                  //                           ),
                  //                         ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 Icon(
                  //                   isExpanded
                  //                       ? Icons.expand_less
                  //                       : Icons.expand_more,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ],
                  //             ),

                  //             const SizedBox(height: 4),

                  //             // ONLY show full list of lessons if expanded
                  //             if (isExpanded) ...[
                  //               const SizedBox(height: 12),
                  //               Column(
                  //                 children:
                  //                     List.generate(lessons.length, (lessonIndex) {
                  //                   final lesson = lessons[lessonIndex];
                  //                   return Column(
                  //                     children: [
                  //                       if (lessonIndex != 0)
                  //                         Padding(
                  //                           padding: const EdgeInsets.symmetric(
                  //                               vertical: 4),
                  //                           child: Divider(
                  //                             color: Colors.grey.shade300,
                  //                             thickness: 1,
                  //                             height: 1,
                  //                           ),
                  //                         ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             vertical: 6),
                  //                         child: Row(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               (lessonIndex + 1)
                  //                                   .toString()
                  //                                   .padLeft(2, '0'),
                  //                               style: const TextStyle(
                  //                                 fontWeight: FontWeight.bold,
                  //                                 fontSize: 14,
                  //                               ),
                  //                             ),
                  //                             const SizedBox(width: 12),
                  //                             Expanded(
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   Text(
                  //                                     lesson['title'],
                  //                                     maxLines: 2,
                  //                                     overflow:
                  //                                         TextOverflow.ellipsis,
                  //                                     style: const TextStyle(
                  //                                       fontSize: 16,
                  //                                       fontWeight: FontWeight.w500,
                  //                                     ),
                  //                                   ),
                  //                                   const SizedBox(height: 2),
                  //                                   Row(
                  //                                     children: [
                  //                                       Text(
                  //                                         lesson['type'] == 'video'
                  //                                             ? 'Video'
                  //                                             : 'Article',
                  //                                         style: const TextStyle(
                  //                                           fontSize: 14,
                  //                                           color: Colors.grey,
                  //                                         ),
                  //                                       ),
                  //                                       if (lesson['duration'] !=
                  //                                           null) ...[
                  //                                         const SizedBox(width: 8),
                  //                                         const Icon(
                  //                                           Icons.circle,
                  //                                           size: 5,
                  //                                           color: Colors.grey,
                  //                                         ),
                  //                                         const SizedBox(width: 8),
                  //                                         Text(
                  //                                           lesson['duration'],
                  //                                           style: const TextStyle(
                  //                                             fontSize: 14,
                  //                                             color: Colors.grey,
                  //                                           ),
                  //                                         ),
                  //                                       ],
                  //                                     ],
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             if (lesson['type'] == 'video')
                  //                               const Icon(
                  //                                 Icons.play_circle_fill,
                  //                                 size: 28,
                  //                                 color: Colors.green,
                  //                               ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   );
                  //                 }),
                  //               ),
                  //             ],
                  //           ],
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),

              // TAB 3: Reviews
              // TAB 3: Resources Tab
                  // ListView.builder(
                  //   padding: const EdgeInsets.all(16),
                  //   itemCount: resources.length,
                  //   itemBuilder: (context, index) {
                  //     final item = resources[index];
                  //     return Container(
                  //       margin: const EdgeInsets.only(bottom: 12),
                  //       padding: const EdgeInsets.all(12),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(12),
                  //         border: Border.all(color: Colors.grey.shade200),
                  //       ),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           // Title and Date
                  //           Expanded(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Text(
                  //                   item['title'],
                  //                   maxLines: 2,
                  //                   overflow: TextOverflow.ellipsis,
                  //                   style: const TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //                 ),
                  //                 const SizedBox(height: 4),
                  //                 Text(
                  //                   item['date'],
                  //                   style: TextStyle(
                  //                     fontSize: 12,
                  //                     color: Colors.grey.shade600,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           const SizedBox(width: 12),
                  //           // Icon Button
                  //           Container(
                  //             padding: const EdgeInsets.all(8),
                  //             decoration: BoxDecoration(
                  //               color: const Color(0xFFDFF5E1),
                  //               shape: BoxShape.circle,
                  //             ),
                  //             child: Icon(
                  //               item['locked'] ? Icons.lock : Icons.download,
                  //               color: Colors.green,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
      ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: const Text(
                  "₹4999",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 7,
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
    );
  }

  VideoPlayerConfiguration videoPlayerConfig() {
    return VideoPlayerConfiguration(
      globalPlaybackControlSettings: GlobalPlaybackControlSettings(
        useGlobalPlaybackController: false,
      ),
      videoSourceConfiguration: VideoSourceConfiguration.youtube(
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
