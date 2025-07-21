import 'package:get/get.dart';

class ExaminstructionsController extends GetxController {
  // Dynamic data
  final examTitle =
      'AI - Generated Quantitative Aptitude\nSectional Test - 01'.obs;
  final duration = '20 Mins.'.obs;
  final maxMarks = '50.0'.obs;

  final instructions = <String>[
    "The exam consists of 25 questions to be answered within the given time limit.",
    "Each question carries 2 marks for a correct answer.",
    "0.5 marks will be deducted for every incorrect answer.",
    "No marks will be deducted for unattempted questions.",
    "Each question has 4 options, only one of which is correct.",
    "Make sure to read each question carefully before selecting your answer.",
    "Do not refresh or leave the test page while the test is in progress.",
    "Use of any unfair means or malpractice will lead to disqualification.",
    "Ensure a stable internet connection throughout the test duration.",
    "By clicking 'Agree and Continue', you accept all the instructions and terms of this examination.",
  ].obs;

  final languages = <String>[
    "English",
    "Hindi",
    "Kannada",
  ].obs;
}
