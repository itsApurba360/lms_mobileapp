import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:lms_app/app/controllers/api_client_controller.dart';
import 'package:lms_app/app/models/course.dart';

class PurchasesController extends GetxController with StateMixin {
  final apiClientController = Get.find<ApiClientController>();
  var purchasedCourses = <Course>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchPurchasedCourses();
  }


  // Fetch purchased courses
  Future<void> fetchPurchasedCourses() async {
    try {
      final response = await apiClientController
          .post('/api/method/lms_360ithub.utils.custom_lms.get_courses', data: {
        'filters': json.encode({'enrolled': 1})
      });
      purchasedCourses.value =
          CourseResponse.fromJson(response.data).message ?? [];
      change(null, status: RxStatus.success());
    } catch (e) {
      log(e.toString());
    }
  }

}
