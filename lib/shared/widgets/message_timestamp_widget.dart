import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTimestampWidget extends StatelessWidget {
  const MessageTimestampWidget({super.key, required this.timestamp});

  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    const datePattern = 'dd MMM yyyy, HH:mm';

    final timestampFormatted =
        DateFormat(datePattern).format(timestamp.toDate());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        timestampFormatted,
        style: const TextStyle(
            color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
      ),
    );
  }
}
