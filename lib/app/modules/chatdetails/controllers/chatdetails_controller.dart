import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Message {
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final String? avatarUrl;

  Message({
    required this.text,
    required this.timestamp,
    this.isMe = true,
    this.avatarUrl,
  });
}

class ChatdetailsController extends GetxController {
  final messages = <Message>[].obs;
  final scrollController = ScrollController();
  final receiverName = 'Srikanth'.obs;
  final receiverAvatar =
      'assets/images/profile-1.jpg'.obs; // Leave empty for default initials

  @override
  void onInit() {
    super.onInit();
    loadDummyMessages();
  }

  void loadDummyMessages() {
    messages.addAll([
      Message(
          text: "Hey, how are you?",
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          isMe: false),
      Message(
          text: "All good, you?",
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isMe: true),
    ]);
  }

  void sendMessage(String text) {
    final newMsg = Message(text: text, timestamp: DateTime.now(), isMe: true);
    messages.add(newMsg);
    scrollToBottom();

    // Fake auto-reply
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(Message(
        text: "That's interesting!",
        timestamp: DateTime.now(),
        isMe: false,
      ));
      scrollToBottom();
    });
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String groupTitle(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDate = DateTime(time.year, time.month, time.day);

    if (msgDate == today) return "Today";
    if (msgDate == yesterday) return "Yesterday";
    return "${msgDate.day}/${msgDate.month}/${msgDate.year}";
  }

  int titleSortValue(String title) {
    if (title == "Today") return 2;
    if (title == "Yesterday") return 1;
    return 0;
  }

  String formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }
}
