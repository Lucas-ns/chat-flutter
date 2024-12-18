import 'package:chat_flutter/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomSelectionPage extends StatelessWidget {
  final String nickname;
  const RoomSelectionPage({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    final roomsCollection = FirebaseFirestore.instance.collection('rooms');
    return Scaffold(
      backgroundColor: const Color(0XFF36393f),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0XFF23272a),
        title: Text('Salas de Chat - $nickname'),
      ),
      body: StreamBuilder(
          stream: roomsCollection.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final rooms = snapshot.data!.docs;
            return ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return ListTile(
                    title: Center(
                      child: Text(
                        '${room['name']}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                  nickname: nickname, roomId: room.id)));
                    },
                  );
                });
          }),
    );
  }
}
