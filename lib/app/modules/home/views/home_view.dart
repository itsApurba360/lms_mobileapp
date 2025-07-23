import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../notifications/views/notifications_view.dart';
import '../../../routes/app_pages.dart';
import '../../notifications/bindings/notifications_binding.dart';
import '../widgets/menu_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState!.openDrawer();
    } else {
      // Fallback if the drawer can't be opened directly
      Scaffold.of(context).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final pageController = PageController();
    final pageIndex = ValueNotifier(0);
    final carouselController = PageController();

    // Auto-scroll carousel
    Timer.periodic(Duration(seconds: 4), (timer) {
      if (carouselController.hasClients) {
        int nextPage = carouselController.page!.round() + 1;
        if (nextPage >= 3) nextPage = 0;
        carouselController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_open),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {
              print('Navigating to notifications...');
              Get.to(
                () => NotificationsView(),
                binding: NotificationsBinding(),
                preventDuplicates: false,
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 100,
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: pageIndex,
        builder: (context, selectedIndex, _) {
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            onTap: (index) {
              switch (index) {
                case 0:
                  pageIndex.value = 0; // Stay on Home and highlight it
                  break;
                case 1:
                  Get.toNamed(Routes.COURSES);
                  break;
                case 2:
                  Get.toNamed(Routes.CHAT);
                  break;
                case 3:
                  Get.toNamed(Routes.PROFILE);
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book), label: "Courses"),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          );
        },
      ),
      body: Container(
        color: const Color.fromARGB(255, 251, 251, 251),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi Prasant 👋', style: TextStyle(fontSize: 18)),
              Text("Let's start learning!",
                  style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 20),
              _buildSearchBox(),
              SizedBox(height: 12),
              _buildImageCarousel(carouselController),
              SizedBox(height: 20),
              _buildGridIcons(),
              SizedBox(height: 20),

              // Text('Continue Learning', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 10),
              // _buildCourseSlider(
              //   pageController: _pageController,
              //   pageIndex: _pageIndex,
              //   courseList: [
              //     _courseCardWithProgress(
              //       title: "Python Advanced Course",
              //       progressPercent: 0.65,
              //       showProgress: true,
              //       showPriceTime: false,
              //       priceText: "₹4999",
              //       durationText: "3:00 hrs",
              //     ),
              //     _courseCardWithProgress(
              //       title: "Flutter for Beginners",
              //       progressPercent: 0.3,
              //       showProgress: true,
              //       showPriceTime: false,
              //       priceText: "₹2999",
              //       durationText: "1:30 hrs",
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Newest Courses',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Add your navigation or action here
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      children: [
                        Text('View All',
                            style: TextStyle(color: Colors.grey.shade600)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              _buildNewestCourses(),
              SizedBox(height: 0),
              // Text('Recommended For You', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 10),
              // _buildCourseSlider(
              //   courseList: [
              //     _courseCardWithProgress(
              //       title: "Mastering Java",
              //       progressPercent: 0.0,
              //       showProgress: false,
              //       showPriceTime: true,
              //       priceText: "₹2499",
              //       durationText: "3:00 hrs",
              //     ),
              //     _courseCardWithProgress(
              //       title: "Kotlin Crash Course",
              //       progressPercent: 0.0,
              //       showProgress: false,
              //       showPriceTime: true,
              //       priceText: "₹1999",
              //       durationText: "2:15 hrs",
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() => TextField(
        decoration: InputDecoration(
          hintText: "Search here...",
          prefixIcon: Icon(Icons.search, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      );

  Widget _buildGridIcons() => GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 2.5,
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.COURSES);
            },
            child: iconTile(Icons.menu_book, 'Courses', Color(0xFFDDEBFF),
                Color.fromARGB(255, 123, 173, 254)),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.TESTSERIES);
            },
            child: iconTile(Icons.help, 'Live Tests & Quizzes',
                Color(0xFFE5DFFF), Color.fromARGB(255, 187, 158, 255)),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.PURCHASES);
            },
            child: iconTile(Icons.play_circle_fill, 'My Puchases',
                Color(0xFFFFE6E6), Color.fromARGB(255, 255, 168, 168)),
          ),
          iconTile(Icons.assignment, 'My\nAssignments', Color(0xFFFFDDE7),
              Color.fromARGB(255, 255, 167, 197)),
        ],
      );

  Widget iconTile(
      IconData icon, String label, Color startColor, Color endColor) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.1),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withOpacity(0.3),
            child: Icon(icon,
                color: const Color.fromARGB(255, 255, 255, 255), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(PageController controller) => SizedBox(
        height: 180,
        child: PageView(
          controller: controller,
          children: List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/banner-1.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          }),
        ),
      );

  Widget _buildCourseSlider({
    required List<Widget> courseList,
    PageController? pageController,
    ValueNotifier<int>? pageIndex,
  }) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) => pageIndex?.value = index,
              children: courseList,
            ),
          ),
          if (pageIndex != null) SizedBox(height: 10),
          if (pageIndex != null)
            ValueListenableBuilder(
              valueListenable: pageIndex,
              builder: (_, index, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(courseList.length, (i) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: index == i ? 12 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: index == i ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNewestCourses() => SizedBox(
        height: 220, // 🔥 Increased from 180 to 220
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            _courseCardV2(
              title: "Python for Beginners",
              price: "₹4999.00",
              duration: "230 Hours",
              showPill: true,
              pillText: "Top Pick",
            ),
            _courseCardV2(
              title: "Web Design for Beginners",
              price: "₹749.00",
              duration: "145 Hours",
            ),
            _courseCardV2(
              title: "The Future of Tech",
              price: "₹4999.00",
              duration: "200 Hours",
              showPill: true,
              pillText: "Trending",
            ),
          ],
        ),
      );

  Widget _courseCardWithProgress({
    required String title,
    required double progressPercent,
    required bool showProgress,
    required bool showPriceTime,
    required String priceText,
    required String durationText,
  }) {
    return SizedBox(
      height: 200,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.network('https://via.placeholder.com/400x240',
                    fit: BoxFit.cover)),
            if (priceText.isNotEmpty)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(priceText,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
            ),
            Positioned(
              bottom: 14,
              left: 14,
              right: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  if (showProgress) ...[
                    SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progressPercent,
                        minHeight: 5,
                        backgroundColor: Colors.white30,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                  if (showPriceTime)
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(durationText,
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ],
                    ),
                  if (showProgress)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${(progressPercent * 100).toInt()}% completed",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _courseCardV2({
    required String title,
    required String price,
    required String duration,
    bool showPill = false,
    String pillText = 'New',
  }) {
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Image.asset('assets/images/python.jpg',
                    fit: BoxFit.cover, width: double.infinity, height: 100),
                if (showPill)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(pillText,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          SizedBox(height: 4),
          Text(price,
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          Text(duration,
              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
