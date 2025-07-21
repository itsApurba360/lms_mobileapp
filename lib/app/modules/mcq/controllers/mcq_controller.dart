import 'package:get/get.dart';
import 'dart:async';

class McqController extends GetxController {
  var timeRemaining = "10:00".obs;
  var timerProgress = 1.0.obs;
  var testName = "Sample Test".obs;

  late Timer _timer;
  final int totalSeconds = 600; // 10 minutes
  int secondsLeft = 600;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        secondsLeft--;

        final minutes = secondsLeft ~/ 60;
        final seconds = secondsLeft % 60;

        timeRemaining.value =
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        timerProgress.value = secondsLeft / totalSeconds; // ⬅️ Progress
      } else {
        _timer.cancel();
        timerProgress.value = 0.0;
        timeRemaining.value = "00:00";
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
