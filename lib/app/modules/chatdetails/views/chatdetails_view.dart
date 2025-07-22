import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chatdetails_controller.dart';

class ChatdetailsView extends GetView<ChatdetailsController> {
  const ChatdetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final inputController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Obx(() {
              final user = controller.receiverName.value;
              final avatar = controller.receiverAvatar.value;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: avatar != null && avatar.isNotEmpty
                    ? CircleAvatar(backgroundImage: AssetImage(avatar))
                    : CircleAvatar(
                        backgroundColor: Colors.green[100],
                        child: Text(
                          user.isNotEmpty ? user[0].toUpperCase() : '?',
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
              );
            }),
            Obx(() => Text(controller.receiverName.value)),
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        color: const Color(0xFFF6F7FB),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                final messages = controller.messages;
                final grouped = <String, List<Message>>{};

                for (var msg in messages) {
                  final title = controller.groupTitle(msg.timestamp);
                  grouped.putIfAbsent(title, () => []).add(msg);
                }

                final sortedKeys = grouped.keys.toList();
                sortedKeys.sort((a, b) => controller
                    .titleSortValue(a)
                    .compareTo(controller.titleSortValue(b)));

                final items = <Widget>[];

                for (final key in sortedKeys) {
                  final msgs = grouped[key]!;
                  if (msgs.isNotEmpty) {
                    items.add(_buildGroupTitle(key));
                    items.addAll(msgs.map(_buildMessageBubble));
                  }
                }

                return ListView(
                  controller: controller.scrollController,
                  reverse: true,
                  padding: const EdgeInsets.all(12),
                  children: items.reversed.toList(),
                );
              }),
            ),
            const Divider(height: 1),
            _buildInputBar(inputController),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupTitle(String group) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(group, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildInputBar(TextEditingController inputController) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.photo, color: Colors.grey),
              onPressed: () {
                // TODO: Add image picker
              },
            ),
            IconButton(
              icon: const Icon(Icons.attach_file, color: Colors.grey),
              onPressed: () {
                // TODO: Add file picker
              },
            ),
            Expanded(
              child: TextField(
                controller: inputController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 143, 143, 143),
                      fontWeight: FontWeight.w400),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 215, 215, 215)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 219, 219, 219)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.green),
              onPressed: () {
                if (inputController.text.trim().isNotEmpty) {
                  controller.sendMessage(inputController.text.trim());
                  inputController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message msg) {
    final bubbleColor = msg.isMe ? Colors.grey[200] : Colors.grey[200];
    final align = msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            msg.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!msg.isMe)
            const CircleAvatar(radius: 16, child: Icon(Icons.person)),
          if (!msg.isMe) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: align,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(msg.isMe ? 18 : 0),
                      bottomRight: Radius.circular(msg.isMe ? 0 : 18),
                    ),
                  ),
                  child: Text(msg.text, style: const TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 2),
                Text(
                  controller.formatTime(msg.timestamp),
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
          if (msg.isMe) const SizedBox(width: 8),
          if (msg.isMe)
            const CircleAvatar(radius: 16, child: Icon(Icons.person)),
        ],
      ),
    );
  }
}
