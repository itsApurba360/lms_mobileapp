// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CourseDetailsView extends StatefulWidget {
  const CourseDetailsView({super.key});

  @override
  State<CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<CourseDetailsView> {
  bool isExpandedDesc = false;
  bool isExpandedLearn = false;

  final String longDescription =
      '''Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. With GetX, state management becomes easy and powerful. In this course, you'll build real-world apps, implement animations, master navigation, and more. Whether you're just starting or looking to level up, this course is your complete guide to becoming a Flutter pro. Flutter is fun, powerful and perfect for cross-platform projects. Build, scale, and ship amazing apps fast!''';

  final List<String> learnPoints = [
    "Build beautiful UIs with Flutter & Dart",
    "Master GetX for state management",
    "Create responsive mobile layouts",
    "Connect APIs and manage async ops",
    "Deploy to Android & iOS",
    "Debug and optimize performance",
    "Write unit and widget tests",
    "Use third-party packages like Dio and Hive",
  ];

  final List<Map<String, dynamic>> courseIncludes = [
    {'icon': Icons.play_circle_outline, 'text': "10 hours on-demand video"},
    {'icon': Icons.article_outlined, 'text': "8 articles"},
    {'icon': Icons.cloud_download, 'text': "20 downloadable resources"},
    {'icon': Icons.all_inclusive, 'text': "Full lifetime access"},
    {'icon': Icons.phone_android, 'text': "Access on mobile and TV"},
    {'icon': Icons.verified, 'text': "Certificate of completion"},
  ];

  final List<String> requirements = [
    "Basic understanding of programming concepts",
    "A computer with internet connection",
    "Willingness to learn Flutter",
  ];

  final List<Map<String, dynamic>> chapters = [
    {
      'title': 'Introduction to Flutter & GetX',
      'lessons': [
        {'title': 'Flutter Overview', 'type': 'video', 'duration': '03:47'},
        {'title': 'Why GetX?', 'type': 'article'},
        {'title': 'Setup & Installation', 'type': 'video', 'duration': '05:15'},
        {
          'title': 'Running Your First App',
          'type': 'video',
          'duration': '04:33'
        },
        {'title': 'Debugging Basics', 'type': 'article'},
      ],
    },
    {
      'title': 'State Management with GetX',
      'lessons': [
        {'title': 'Reactive Programming', 'type': 'video', 'duration': '06:00'},
        {'title': 'GetBuilder vs Obx', 'type': 'article'},
        {'title': 'Dependency Injection', 'type': 'video', 'duration': '04:45'},
      ],
    },
  ];

  final List<Map<String, dynamic>> resources = [
    {
      'title': 'Flutter Documentation',
      'date': '2023-01-01',
      'locked': false,
    },
    {
      'title': 'GetX Documentation',
      'date': '2023-01-02',
      'locked': true,
    },
    {
      'title': 'Flutter & GetX Course',
      'date': '2023-01-03',
      'locked': false,
    },
  ];

  List<bool> isChapterExpanded = [];

  @override
  Widget build(BuildContext context) {
    const bodyGrey = Color.fromARGB(255, 244, 244, 244);

    // 💥 Dynamically fix expansion state length
    if (isChapterExpanded.length != chapters.length) {
      isChapterExpanded = List.generate(chapters.length, (index) => false);
    }

    return Scaffold(
      backgroundColor: bodyGrey,
      appBar: AppBar(
        automaticallyImplyLeading: false, // prevent default back arrow
        titleSpacing: 0, // make sure title starts from the left
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text(
              'Course Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
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
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 200,
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const Icon(Icons.play_circle_fill,
                              size: 64, color: Colors.black45),
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
                            child: const Text(
                              "Flutter",
                              style: TextStyle(
                                color: Color.fromARGB(255, 9, 115, 12),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Master Flutter & GetX in 2025",
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
                        children: const [
                          Text("₹499",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
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
              _buildInfoTab(),

              // TAB 2: Chapters Tab (with RangeError fix)
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chapters.length,
                itemBuilder: (context, chapterIndex) {
                  final chapter = chapters[chapterIndex];
                  final lessons = chapter['lessons'] as List<dynamic>;
                  final bool isExpanded =
                      isChapterExpanded[chapterIndex] == true;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isChapterExpanded[chapterIndex] = !isExpanded;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${(chapterIndex + 1).toString().padLeft(2, '0')}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chapter['title'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (!isExpanded)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          '${lessons.length > 5 ? 5 : lessons.length} lessons',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                                color: Colors.grey,
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // ONLY show full list of lessons if expanded
                          if (isExpanded) ...[
                            const SizedBox(height: 12),
                            Column(
                              children:
                                  List.generate(lessons.length, (lessonIndex) {
                                final lesson = lessons[lessonIndex];
                                return Column(
                                  children: [
                                    if (lessonIndex != 0)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1,
                                          height: 1,
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${(lessonIndex + 1).toString().padLeft(2, '0')}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lesson['title'],
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Row(
                                                  children: [
                                                    Text(
                                                      lesson['type'] == 'video'
                                                          ? 'Video'
                                                          : 'Article',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    if (lesson['duration'] !=
                                                        null) ...[
                                                      const SizedBox(width: 8),
                                                      const Icon(
                                                        Icons.circle,
                                                        size: 5,
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        lesson['duration'],
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (lesson['type'] == 'video')
                                            const Icon(
                                              Icons.play_circle_fill,
                                              size: 28,
                                              color: Colors.green,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),

              // TAB 3: Reviews
              // TAB 3: Resources Tab
              ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final item = resources[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['date'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Icon Button
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF5E1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['locked'] ? Icons.lock : Icons.download,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    const bodyGrey = Color(0xFFF5F5F5);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("What you'll learn",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Stack(
            children: [
              Column(
                children: List.generate(
                  isExpandedLearn
                      ? learnPoints.length
                      : (learnPoints.length > 6 ? 6 : learnPoints.length),
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check, size: 20, color: Colors.black87),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          learnPoints[index],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isExpandedLearn && learnPoints.length > 6)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [bodyGrey.withOpacity(0.0), bodyGrey],
                        // ),
                        ),
                  ),
                ),
            ],
          ),
          if (learnPoints.length > 6)
            TextButton(
              onPressed: () {
                setState(() {
                  isExpandedLearn = !isExpandedLearn;
                });
              },
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: Text(isExpandedLearn ? "View Less" : "View More"),
            ),
          const SizedBox(height: 24),
          Text("This course includes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...courseIncludes.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(item['icon'], size: 20, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(item['text'], style: const TextStyle(fontSize: 16)),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text("Requirements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...requirements.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\u2022 ", style: TextStyle(fontSize: 20)),
                    Expanded(
                      child: Text(item, style: const TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 24),
          Text("Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpandedDesc
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              longDescription,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
            secondChild: Text(
              longDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                isExpandedDesc = !isExpandedDesc;
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            child: Text(isExpandedDesc ? "View Less" : "View More"),
          ),
        ],
      ),
    );
  }
}
