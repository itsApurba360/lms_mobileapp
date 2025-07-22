import 'package:get/get.dart';

class ResultController extends GetxController {
  final RxInt currentSectionIndex = 0.obs;

  final List<SectionModel> sections = [
    SectionModel(
      title: 'Section 1',
      questions: [
        QuestionModel(
          questionText: 'What is the capital of India?',
          options: ['Mumbai', 'Delhi', 'Kolkata', 'Chennai'],
          correctIndex: 1,
          rationalText: 'Delhi is the capital of India.',
          videoUrl:
              'https://www.youtube.com/watch?v=1G4isv_Fylg', // Sample video
        ),
        QuestionModel(
          questionText: 'Which gas do plants absorb?',
          options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Helium'],
          correctIndex: 1,
          rationalText: 'Plants absorb carbon dioxide for photosynthesis.',
          videoUrl: '', // No video
        ),
      ],
    ),
    SectionModel(
      title: 'Section 2',
      questions: [
        QuestionModel(
          questionText: 'What is the boiling point of water?',
          options: ['90°C', '80°C', '100°C', '110°C'],
          correctIndex: 2,
          rationalText:
              'Water boils at 100°C at standard atmospheric pressure.',
          videoUrl:
              'https://www.youtube.com/watch?v=G0HzWOB1CSI', // Sample video
        ),
      ],
    ),
    SectionModel(
      title: 'Section 3',
      questions: [
        QuestionModel(
          questionText: 'Which is the largest continent?',
          options: ['Africa', 'Asia', 'Europe', 'Antarctica'],
          correctIndex: 1,
          rationalText:
              'Asia is the largest continent in both area and population.',
          videoUrl: '', // No video
        ),
      ],
    ),
    SectionModel(
      title: 'Section 4',
      questions: [
        QuestionModel(
          questionText: 'How many planets are in the Solar System?',
          options: ['7', '8', '9', '10'],
          correctIndex: 1,
          rationalText: 'There are 8 planets in the Solar System.',
          videoUrl:
              'https://www.youtube.com/watch?v=libKVRa01L8', // Sample video
        ),
      ],
    ),
  ];

  void resetUserSelections() {
    for (var section in sections) {
      for (var q in section.questions) {
        q.selectedIndex = null;
      }
    }
  }

  int get totalCorrectAnswers {
    int correct = 0;
    for (var section in sections) {
      for (var q in section.questions) {
        if (q.selectedIndex != null && q.selectedIndex == q.correctIndex) {
          correct++;
        }
      }
    }
    return correct;
  }

  int get totalQuestions {
    return sections.fold(0, (sum, section) => sum + section.questions.length);
  }

  double get scorePercent =>
      totalQuestions == 0 ? 0.0 : (totalCorrectAnswers / totalQuestions) * 100;
}

// Models
class SectionModel {
  final String title;
  final List<QuestionModel> questions;

  SectionModel({required this.title, required this.questions});
}

class QuestionModel {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String rationalText;
  final String videoUrl;
  int? selectedIndex;

  QuestionModel({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.rationalText,
    required this.videoUrl,
    this.selectedIndex,
  });
}
