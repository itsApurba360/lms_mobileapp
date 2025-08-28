import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_app/app/models/course.dart';
import 'package:lms_app/app/routes/app_pages.dart';
import '../controllers/purchases_controller.dart';

class PurchasesView extends GetView<PurchasesController> {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: const Color.fromARGB(255, 244, 244, 244),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Purchases'),
          centerTitle: true,
        ),
        body: controller.obx(
          (state) => RefreshIndicator(
            onRefresh: controller.fetchPurchasedCourses,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: controller.purchasedCourses.length,
              itemBuilder: (context, index) {
                return _purchaseCard(controller.purchasedCourses[index]);
              },
            ),
          ),
          onEmpty: const Center(child: Text('No courses found')),
        ),
      ),
    );
  }

  Widget _purchaseCard(Course course) {
    // final double progress = course.progress ?? 0.0;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.COURSE_DETAILS,
          arguments: {
            'id': course.name, // Provide a default value
            'course': course,
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
                    child: CachedNetworkImage(
                      imageUrl: controller.apiClientController.hostUrl! +
                          course.image!,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
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
                      course.title!,
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
                          i < course.rating! ? Icons.star : Icons.star_border,
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
                          course.customCourseDuration!.toString(),
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
                        value: 0,
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
                          '${(0 * 100).toStringAsFixed(0)}% completed',
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
