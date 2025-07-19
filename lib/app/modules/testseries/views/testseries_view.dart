import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/modules/testseries/controllers/testseries_controller.dart'; // 👈 Use absolute import ONLY

class TestseriesView extends GetView<TestseriesController> {
  const TestseriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<TestseriesController>(); // ✅ Use Get.find(), not Get.put()

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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text('Test Series'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Obx(() => Row(
                children: [
                  _buildTab("Ongoing", 0, controller),
                  _buildTab("Attempted", 1, controller),
                ],
              )),
          const SizedBox(height: 10),
          Obx(() => controller.selectedTab.value == 0
              ? _buildOngoingSection(bannerController, currentPage, controller)
              : _buildAttemptedSection(controller)),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, TestseriesController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectedTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedTab.value == index
                    ? Colors.green
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: controller.selectedTab.value == index
                  ? Colors.green
                  : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingSection(PageController bannerController,
      RxInt currentPage, TestseriesController controller) {
    return Column(
      children: [
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
                  child: Image.network(
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
        const SizedBox(height: 8),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(controller.bannerImages.length, (index) {
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
      ],
    );
  }

  Widget _buildAttemptedSection(TestseriesController controller) {
    return Expanded(
      child: ListView.builder(
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
      ),
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
                      TextSpan(
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
                    // Add your navigation logic or whatever you want here
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
