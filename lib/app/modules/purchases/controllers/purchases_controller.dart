import 'package:get/get.dart';

class PurchasesController extends GetxController {
  // Reactive list of purchases
  final purchasesList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadPurchases();
  }

  void _loadPurchases() {
    // Simulating static data — could come from API in real use case
    purchasesList.value = [
      {
        "image": "assets/images/1.jpg",
        "title": "Flutter for Beginners",
        "rating": 4,
        "duration": "4 hrs",
        "progress": 0.75,
      },
      {
        "image": "assets/images/2.png",
        "title": "React Crash Course",
        "rating": 5,
        "duration": "6 hrs",
        "progress": 0.43,
      },
      {
        "image": "assets/images/3.png",
        "title": "Learn Python Basics",
        "rating": 3,
        "duration": "3 hrs",
        "progress": 0.92,
      },
    ];
  }

  // Optional: update progress for a specific course
  void updateProgress(int index, double newProgress) {
    if (index >= 0 && index < purchasesList.length) {
      purchasesList[index]['progress'] = newProgress.clamp(0.0, 1.0);
      purchasesList.refresh(); // Force UI update
    }
  }
}
