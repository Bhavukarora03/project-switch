import 'package:flutter/material.dart';

@immutable
class MessageData {
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String messageTime;
  final String profileImage;

  const MessageData(
      {required this.senderName,
      required this.message,
      required this.messageDate,
      required this.messageTime,
      required this.profileImage});
}
