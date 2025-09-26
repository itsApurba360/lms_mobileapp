import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final prodBaseUrl = 'https://skillhub.360ithub.com'.obs;
  final devBaseUrl = 'http://192.168.1.106:8004'.obs;

  final baseUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      baseUrl.value = devBaseUrl.value;
    } else {
      baseUrl.value = prodBaseUrl.value;
    }
  }
}
