import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/examlist_controller.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class ExamlistView extends GetView<ExamlistController> {
  const ExamlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Exam List'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.examList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.examList.length + 1, // +1 for banner
          itemBuilder: (context, index) {
            if (index == 0) {
              // Banner image
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/banner-1.jpg',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }

            final exam = controller.examList[index - 1];
            return _buildExamCard(exam);
          },
        );
      }),
    );
  }

  Widget _buildExamCard(Map<String, dynamic> exam) {
    final bool isLocked = exam['locked'] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🏷️ Tags and Title Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  children: exam['tags']
                      .map<Widget>((tag) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getTagColor(tag).withOpacity(0.1),
                              border: Border.all(color: _getTagColor(tag)),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tag.toUpperCase(),
                              style: TextStyle(
                                color: _getTagColor(tag),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 4),
                Text(
                  exam['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${exam['questions']} Qs · ${exam['duration']} · ${exam['marks']} Marks',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // 🌐 Language and Start/Unlock Button
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 253, 255),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam['languages'].join(', '),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isLocked ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (isLocked) {
                      Get.snackbar(
                        "Locked",
                        "This test is locked. Please unlock to continue.",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.black,
                      );
                    } else {
                      Get.toNamed('/start-test');
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLocked) ...[
                        const Text(
                          'Unlock Test',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.lock, size: 16, color: Colors.red),
                      ] else ...[
                        const Text(
                          'Start Test',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ],
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
      case 'premium':
        return Colors.orange;
      case 'live test':
        return Colors.pink;
      default:
        return Colors.blueGrey;
    }
  }
}
