import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy data
    notifications.value = [
      {
        'title': 'Order Confirmed',
        'message': 'Your order #2312 has been confirmed.',
        'dateTime': DateTime.now().subtract(const Duration(minutes: 15)),
        'read': false,
      },
      {
        'title': 'Flash Sale 🔥',
        'message': 'Up to 70% off on electronics. Ends today!',
        'dateTime': DateTime.now().subtract(const Duration(hours: 2)),
        'read': true,
      },
      {
        'title': 'Update Available',
        'message': 'A new version of the app is ready to install.',
        'dateTime': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        'read': true,
      },
    ];
  }
}
