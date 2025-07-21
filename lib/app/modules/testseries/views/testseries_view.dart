import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/testseries/controllers/testseries_controller.dart';

class TestseriesView extends GetView<TestseriesController> {
  const TestseriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TestseriesController>();
    final PageController bannerController = PageController();
    final RxInt currentPage = 0.obs;

    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (bannerController.hasClients) {
        int nextPage = bannerController.page!.round() + 1;
        if (nextPage >= controller.bannerImages.length) nextPage = 0;
        bannerController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        appBar: AppBar(
          backgroundColor: Colors.white, // ✅ White background
          title: const Text(
            'Test Series',
            style: TextStyle(color: Colors.black), // ✅ Title text black
          ),
          centerTitle: true,
          elevation: 1,
          iconTheme:
              const IconThemeData(color: Colors.black), // back icon black
          bottom: const TabBar(
            labelColor: Colors.green, // ✅ Active tab text color
            unselectedLabelColor: Colors.black54, // ✅ Inactive tab text color
            indicatorColor: Colors.green, // ✅ Active tab underline color
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Ongoing'),
              Tab(text: 'Attempted'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOngoingSection(bannerController, currentPage, controller),
            _buildAttemptedSection(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingSection(PageController bannerController,
      RxInt currentPage, TestseriesController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: bannerController,
              onPageChanged: (index) => currentPage.value = index,
              itemCount: controller.bannerImages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      controller.bannerImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Text(
                          'Image not available',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(controller.bannerImages.length, (index) {
                  bool isActive = currentPage.value == index;
                  return Container(
                    width: isActive ? 16 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isActive ? Colors.green : Colors.grey,
                    ),
                  );
                }),
              )),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: controller.ongoingTests.length,
            itemBuilder: (context, index) {
              final test = controller.ongoingTests[index];
              return _buildExamCard(test);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(Map<String, dynamic> test) {
    final bool hasDiscount = test['discount'] != null && test['discount'] > 0;
    final double price = test['price'];
    final double discountedPrice =
        hasDiscount ? price - (price * (test['discount'] / 100)) : price;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      test['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (hasDiscount)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red.shade600,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${test['discount']}% OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 84,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child: Text(
                          test['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '₹${discountedPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (hasDiscount)
                            Text(
                              '₹${price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          const Spacer(),
                          SizedBox(
                            height: 34,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Get.toNamed('/buy/${test['id']}');
                              },
                              child: const Text(
                                'Buy Now',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () {
              print('Share tapped: ${test['title']}');
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(6),
              child: const Icon(Icons.share, size: 18, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttemptedSection(TestseriesController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.attemptedTests.length,
      itemBuilder: (context, index) {
        final test = controller.attemptedTests[index];
        return AttemptedCard(
          title: test['title'],
          resultDate: test['resultDate'],
          attemptedDate: test['attemptedDate'],
          tags: List<String>.from(test['tags']),
        );
      },
    );
  }
}

class AttemptedCard extends StatelessWidget {
  final String title;
  final String resultDate;
  final String attemptedDate;
  final List<String> tags;

  const AttemptedCard({
    super.key,
    required this.title,
    required this.resultDate,
    required this.attemptedDate,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getTagColor(tag).withOpacity(0.1),
                            border: Border.all(color: _getTagColor(tag)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: TextStyle(
                              color: _getTagColor(tag),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Results out on : ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: resultDate,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFECECEC)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Attempted on',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          attemptedDate,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  ),
                  onPressed: () {
                    Get.toNamed('/result');
                  },
                  child: const Text(
                    'View Results',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'free':
        return Colors.green;
      case 'live test':
        return Colors.pink;
      case 'premium':
        return Colors.orange;
      default:
        return Colors.blueGrey;
    }
  }
}
