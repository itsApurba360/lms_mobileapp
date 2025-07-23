import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import '../controllers/purchases_controller.dart';

class PurchasesView extends GetView<PurchasesController> {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    final purchasesList = [
      {
        "image": "assets/images/1.jpg",
        "title": "Flutter for Beginners",
        "rating": 4,
        "duration": "4 hrs",
        "progress": 0.75,
      },
      {
        "image": "assets/images/2.png",
        "title": "React Crash Course",
        "rating": 5,
        "duration": "6 hrs",
        "progress": 0.43,
      },
      {
        "image": "assets/images/3.png",
        "title": "Learn Python Basics",
        "rating": 3,
        "duration": "3 hrs",
        "progress": 0.92,
      },
    ];

    return Container(
      color: const Color.fromARGB(255, 244, 244, 244),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
          title: const Text('My Purchases'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: purchasesList.length,
          itemBuilder: (_, i) => _purchaseCard(purchasesList[i]),
        ),
      ),
    );
  }

  Widget _purchaseCard(Map<String, dynamic> course) {
    final double progress = course['progress'] ?? 0.0;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.COURSE_DETAILS,
          arguments: {
            'courseId': course['id'] ?? '1', // Provide a default value
            'courseTitle': course['title'] ?? 'Course Title',
            'courseImage': course['image'] ?? 'assets/images/placeholder.png',
            'progress': progress,
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Image
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 110,
                  height: 110,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      course["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Text + progress
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      course["title"],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Rating stars
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < course["rating"] ? Icons.star : Icons.star_border,
                          size: 14,
                          color: Colors.orange,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Duration row
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          course["duration"],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // % Completed
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${(progress * 100).toStringAsFixed(0)}% completed',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
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
    );
  }
}
