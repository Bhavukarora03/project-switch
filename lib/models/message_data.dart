import 'package:flutter/material.dart';

@immutable
class MessageData {
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String messageTime;
  final String profileImage;

  const MessageData(
      {this.senderName,
      this.message,
      this.messageDate,
      this.messageTime,
      this.profileImage});
}
