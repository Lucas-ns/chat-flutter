import 'package:chat_flutter/model/message_model.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final MessageModel messageModel;
  final bool isMe;
  const ChatWidget({super.key, required this.messageModel, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: isMe ? Colors.redAccent : Colors.blue,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              messageModel.nickname,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              messageModel.text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
