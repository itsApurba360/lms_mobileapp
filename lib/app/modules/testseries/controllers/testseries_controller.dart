import 'package:get/get.dart';

class TestseriesController extends GetxController {
  var selectedTab = 0.obs;
  var currentImageIndex = 0.obs;

  /// 🔁 Banner Images for PageView Carousel
  final List<String> bannerImages = [
    'assets/images/banner-1.jpg',
    'assets/images/banner-1.jpg',
    'assets/images/banner-1.jpg',
  ];

  /// 🧪 Ongoing Test Series Data (with optional discount)
  final List<Map<String, dynamic>> ongoingTests = [
    {
      'id': 1,
      'title': 'AIIMS NORCET 8 Full Test Series',
      'image': 'assets/images/1.jpg',
      'price': 499.0,
      'discount': 40,
    },
    {
      'id': 2,
      'title': 'UP Staff Nurse Mock Test (Premium)',
      'image': 'assets/images/2.png',
      'price': 299.0,
      'discount': 0,
    },
    {
      'id': 3,
      'title': 'General Nursing Practice Set',
      'image': 'assets/images/3.png',
      'price': 199.0,
      'discount': 20,
    },
    {
      'id': 4,
      'title': 'State Level Mock Combo',
      'image': 'assets/images/4.png',
      'price': 599.0,
      'discount': 50,
    },
    {
      'id': 5,
      'title': 'KGMU Super Test Series',
      'image': 'assets/images/5.jpg',
      'price': 449.0,
      'discount': 10,
    },
  ];

  /// ✅ Attempted Test Data
  final List<Map<String, dynamic>> attemptedTests = [
    {
      'title': 'Physics NEET Crash Test Series',
      'resultDate': '20 July 2025',
      'attemptedDate': '18 July 2025',
      'tags': ['Free'],
    },
    {
      'title': 'Biology Full Length Mock',
      'resultDate': '22 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Live Test'],
    },
    {
      'title': 'Chemistry Final Premium Set',
      'resultDate': '25 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Premium', 'Live Test'],
    },
    {
      'title': 'Physics NEET Series',
      'resultDate': '25 July 2025',
      'attemptedDate': '19 July 2025',
      'tags': ['Free', 'Live Test'],
    },
    {
      'title': 'Mathematics Advanced Mock Test',
      'resultDate': '28 July 2025',
      'attemptedDate': '20 July 2025',
      'tags': ['Premium', 'Online'],
    },
  ];
}
