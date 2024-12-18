import 'package:chat_flutter/model/message_model.dart';
import 'package:chat_flutter/providers/chat_provider.dart';
import 'package:chat_flutter/shared/widgets/input_message_widget.dart';
import 'package:chat_flutter/shared/widgets/message_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.roomId, required this.nickname});

  final String roomId;
  final String nickname;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatProvider chatProvider =
      ChatProvider(firebaseFirestore: FirebaseFirestore.instance);
  final messageController = TextEditingController();

  List<QueryDocumentSnapshot> messageList = [];

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0XFF36393f),
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: const Color(0XFF23272a),
          elevation: 1,
          title: FutureBuilder(
            future: chatProvider.getRoomName(widget.roomId),
            builder: (context, snapshot) {
              final roomName = snapshot.data ?? "Desconhecida";
              return Text(roomName, style: const TextStyle(fontSize: 20));
            },
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: chatProvider.getMessageList(widget.roomId),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        messageList = snapshot.data!.docs;

                        if (messageList.isNotEmpty) {
                          return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: messageList.length,
                            reverse: true,
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                _buildItem(index, messageList[index]),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'Sem mensagens',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                    },
                  ),
                ),
                InputMessageWidget(
                  messageController: messageController,
                  handleSubmit: sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messageController.clear();
      chatProvider.sendMessage(message.trim(), widget.nickname, widget.roomId);
    }
  }

  _buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      final chatMessage = MessageModel.fromDocument(documentSnapshot);
      final isMe = chatMessage.nickname == widget.nickname;

      return MessageBubbleWidget(chatMessage: chatMessage, isMe: isMe);
    }
  }
}
