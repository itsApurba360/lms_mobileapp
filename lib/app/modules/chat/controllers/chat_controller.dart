import 'package:get/get.dart';

import '../../chatdetails/bindings/chatdetails_binding.dart';
import '../../chatdetails/views/chatdetails_view.dart';

class ChatController extends GetxController {
  final chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  void fetchChats() {
    var mockChats = [
      ChatModel(
        name: 'Srikanth',
        lastMessage: 'Hey, how are you?',
        time: '10:30 AM',
        avatarUrl: 'assets/images/profile-1.jpg',
        isActive: true,
      ),
      ChatModel(
        name: 'Siri',
        lastMessage: 'See you tomorrow!',
        time: 'Yesterday',
        avatarUrl: 'assets/images/profile-2.jpg',
        isActive: true,
      ),
      ChatModel(
        name: 'Mohan',
        lastMessage: 'Hello!',
        time: '2 days ago',
        avatarUrl: '',
        isActive: false,
      ),
    ];
    chatList.assignAll(mockChats);
  }

  void openChat(ChatModel chat) {
    Get.to(
      () => const ChatdetailsView(),
      arguments: chat,
      binding: ChatdetailsBinding(),
    );
  }
}

class ChatModel {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;
  final bool isActive;

  ChatModel({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.isActive,
  });
}
