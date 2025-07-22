import 'package:get/get.dart';

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
    this.isActive = false, // default to false just in case
  });
}

class ChatController extends GetxController {
  final RxList<ChatModel> chatList = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  void loadChats() {
    chatList.value = [
      ChatModel(
        name: 'Priya Sharma',
        lastMessage: 'Hey, did you check the doc?',
        time: '10:24 AM',
        avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
        isActive: true,
      ),
      ChatModel(
        name: 'Amit Verma',
        lastMessage: 'Let’s catch up tomorrow.',
        time: 'Yesterday',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      ChatModel(
        name: 'Sneha Gupta',
        lastMessage: 'Thanks! Got it ✅',
        time: 'Mon',
        avatarUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
        isActive: true,
      ),
      ChatModel(
        name: 'Ravi Kumar',
        lastMessage: 'Call me when free.',
        time: 'Sun',
        avatarUrl: 'https://randomuser.me/api/portraits/men/81.jpg',
      ),
    ];
  }

  void openChat(ChatModel chat) {
    // Navigate or trigger something
    Get.snackbar('Chat opened', 'Opening chat with ${chat.name}');
    // You can navigate using: Get.to(() => ChatDetailView(chat: chat));
  }
}
