import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../result/views/result_view.dart';

class McqController extends GetxController {
  // Timer & UI display
  var timeRemaining = "10:00".obs;
  var elapsedTime = "00:00".obs;
  var timerProgress = 1.0.obs;
  var testName = "Sample Test".obs;

  late Timer _timer;
  final int totalSeconds = 600; // 10 minutes
  int secondsLeft = 600;
  int elapsedSeconds = 0;

  // Questions
  final questions = <Map<String, dynamic>>[
    {
      "question": "What is the capital of France?",
      "options": ["Berlin", "Paris", "London", "Rome"],
      "answerIndex": 1
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Earth", "Mars", "Jupiter", "Venus"],
      "answerIndex": 1
    },
    {
      "question": "Who wrote Hamlet?",
      "options": ["Charles Dickens", "Shakespeare", "Tolstoy", "Homer"],
      "answerIndex": 1
    },
  ];

  var currentQno = 1.obs;
  var question = ''.obs;
  var options = <String>[].obs;
  var selectedOption = (-1).obs;
  var selectedAnswers = <int>[].obs;

  var isWishlisted = false.obs;
  var isStarred = false.obs;
  var saveNextDisabled = false.obs;
  var isLastQuestion = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestion(0);
    startTimer();
  }

  void loadQuestion(int index) {
    final q = questions[index];
    question.value = q["question"];
    options.assignAll(List<String>.from(q["options"]));
    selectedOption.value = -1;

    isLastQuestion.value = index == questions.length - 1;
  }

  void selectOption(int index) {
    selectedOption.value = index;
  }

  void toggleWishlist() => isWishlisted.toggle();
  void toggleStarred() => isStarred.toggle();

  void goToPreviousQuestion() {
    if (currentQno.value > 1) {
      currentQno.value--;
      loadQuestion(currentQno.value - 1);
    }
  }

  void goToNextQuestion() {
    if (currentQno.value < questions.length) {
      currentQno.value++;
      loadQuestion(currentQno.value - 1);
    }
  }

  void saveAndNext() {
    if (saveNextDisabled.value) return;

    // Save answer
    if (selectedAnswers.length >= currentQno.value) {
      selectedAnswers[currentQno.value - 1] = selectedOption.value;
    } else {
      selectedAnswers.add(selectedOption.value);
    }

    saveNextDisabled.value = true;

    Future.delayed(const Duration(seconds: 1), () {
      saveNextDisabled.value = false;
    });

    if (!isLastQuestion.value) {
      goToNextQuestion();
    } else {
      showSubmitConfirmation();
    }
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (i < selectedAnswers.length &&
          selectedAnswers[i] == questions[i]["answerIndex"]) {
        score++;
      }
    }
    return score;
  }

  void submitTest() {
    _timer.cancel();
    final score = calculateScore();

    Get.off(() => const ResultView(), arguments: {
      'score': score,
      'total': questions.length,
    });
  }

  void showSubmitConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text("Submit Section 1?"),
        content: const Text("Are you sure you want to submit Section 1?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              submitTest();
            },
            child: const Text("Yes, Submit"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        secondsLeft--;
        elapsedSeconds++;

        timeRemaining.value =
            "${(secondsLeft ~/ 60).toString().padLeft(2, '0')}:${(secondsLeft % 60).toString().padLeft(2, '0')}";
        elapsedTime.value =
            "${(elapsedSeconds ~/ 60).toString().padLeft(2, '0')}:${(elapsedSeconds % 60).toString().padLeft(2, '0')}";
        timerProgress.value = secondsLeft / totalSeconds;
      } else {
        _timer.cancel();
        Get.snackbar("Time’s Up!", "Auto-submitting your test...");
        submitTest();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
