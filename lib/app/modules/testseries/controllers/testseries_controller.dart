import 'package:get/get.dart';

class TestseriesController extends GetxController {
  var selectedTab = 0.obs;
  var currentImageIndex = 0.obs;

  final List<String> bannerImages = [
    'https://picsum.photos/id/1011/600/300',
    'https://picsum.photos/id/1012/600/300',
    'https://picsum.photos/id/1013/600/300',
  ];

  final List<Map<String, dynamic>> attemptedTests = [
    {
      'title': 'Physics NEET Crash Test Series',
      'resultDate': '20 July 2025',
      'attemptedDate': '18 July 2025',
      'tags': ['Free']
    },
    {
      'title': 'Biology Full Length Mock',
      'resultDate': '22 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Live Test']
    },
    {
      'title': 'Chemistry Final Premium Set',
      'resultDate': '25 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Premium', 'Live Test']
    },
    {
      'title': 'Physics NEET  Series',
      'resultDate': '25 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Free', 'Live Test']
    },
    {
      'title': 'Mathematics Advanced Mock Test',
      'resultDate': '28 July 2025',
      'attemptedDate': '20 July 2025',
      'tags': ['Premium', 'Online', 'Test Series']
    },
  ];
}
