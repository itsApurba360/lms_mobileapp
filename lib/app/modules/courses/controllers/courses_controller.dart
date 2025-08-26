import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/models/course.dart';

class CoursesController extends GetxController with StateMixin {
  final coursesList = <Course>[].obs;

  final apiClientController = Get.find<ApiClientController>();

  @override
  void onInit() {
    super.onInit();
    getCourseList();
  }

  // Get course list
  Future<void> getCourseList() async {
    try {
      final response = await apiClientController.post(
          '/api/method/lms_360ithub.utils.custom_lms.get_courses',
          data: {});

      coursesList.value = CourseResponse.fromJson(response.data).message ?? [];

      log(coursesList.toString());

      change(null, status: RxStatus.success());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Get course price
  String getCoursePrice(Course course) {
    if (course.customDiscount != null && course.customDiscount! > 0) {
      return '${course.customDiscountedPrice?.toStringAsFixed(2) ?? '0'} ₹';
    } else {
      return '${course.coursePrice?.toStringAsFixed(2) ?? '0'} ₹';
    }
  }
}
