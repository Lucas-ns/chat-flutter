import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  Timestamp timestamp = Timestamp.now();
  String text = '';
  String nickname = '';

  MessageModel(
      {required this.text, required this.timestamp, required this.nickname});

  MessageModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'] as Timestamp;
    text = json['text'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['text'] = text;
    data['nickname'] = nickname;

    return data;
  }

  factory MessageModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String author = documentSnapshot.get('nickname');
    String message = documentSnapshot.get('text');
    Timestamp timestamp = documentSnapshot.get('timestamp');

    return MessageModel(nickname: author, text: message, timestamp: timestamp);
  }
}
