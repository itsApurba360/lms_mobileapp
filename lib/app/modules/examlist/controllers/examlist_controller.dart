import 'package:get/get.dart';

class ExamlistController extends GetxController {
  var examList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchExams();
  }

  void fetchExams() {
    examList.value = [
      {
        'title': 'General Intelligence and Reasoning Sectional Test - 01',
        'tags': ['Free'],
        'questions': 25,
        'duration': '18 mins',
        'marks': 50,
        'languages': ['English', 'Hindi'],
        'locked': false, // Free test → unlocked
      },
      {
        'title': 'Quantitative Aptitude Mock Test - 02',
        'tags': ['Premium'],
        'questions': 30,
        'duration': '22 mins',
        'marks': 60,
        'languages': ['English'],
        'locked': true, // Premium test → locked
      },
      {
        'title': 'Quantitative Aptitude Mock Test - 03',
        'tags': ['Premium'],
        'questions': 30,
        'duration': '22 mins',
        'marks': 60,
        'languages': ['English'],
        'locked': true, // Premium test → locked
      },
      // Add more tests below
    ];
  }
}
