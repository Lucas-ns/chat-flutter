import 'package:chat_flutter/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatProvider {
  final FirebaseFirestore firebaseFirestore;

  ChatProvider({required this.firebaseFirestore});

  Stream<QuerySnapshot> getMessageList(String roomId) {
    return firebaseFirestore
        .collection('/rooms/$roomId/messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<String> getRoomName(String roomId) async {
    final docRef = firebaseFirestore.collection('rooms').doc(roomId);
    final docSnapshot = await docRef.get();

    final data = docSnapshot.data() as Map<String, dynamic>;
    return data['name'];
  }

  void sendMessage(String message, String author, String roomId) {
    MessageModel chatMessages = MessageModel(
        text: message, timestamp: Timestamp.now(), nickname: author);
    firebaseFirestore
        .collection('/rooms/$roomId/messages')
        .add(chatMessages.toJson());
  }
}
