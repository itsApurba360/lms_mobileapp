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
      final response = await apiClientController.getList('LMS Course');

      coursesList.value = CourseResponse.fromJson(response.data).message ?? [];

      log(coursesList.toString());

      change(null, status: RxStatus.success());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Get course price
  getCoursePrice(Course course) {
    if (course.customDiscount != null && course.customDiscount! > 0) {
      return course.customDiscountedPrice;
    } else {
      return course.coursePrice;
    }
  }
}
