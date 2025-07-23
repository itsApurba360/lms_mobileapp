import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notifications_controller.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  String formatDateTime(DateTime dt) {
    final hours = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minutes = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    final date = '${dt.day}/${dt.month}/${dt.year}';
    return '$date • $hours:$minutes $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        final notifications = controller.notifications;

        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              '🎉 You’re all caught up!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = notifications[index];
            final formatted = formatDateTime(item['dateTime']);
            final isRead = item['read'] ?? false;

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isRead
                    ? Colors.white
                    : const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(14),
                border: Border(
                  left: BorderSide(
                    color: isRead ? Colors.transparent : Colors.green,
                    width: 2,
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: Title + Time + NEW badge
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and message
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight:
                                    isRead ? FontWeight.w500 : FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['message'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formatted,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
