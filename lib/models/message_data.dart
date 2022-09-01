
import 'package:flutter/material.dart';

@immutable
class MessageData{
  final String SenderName;
  final String message;
  final DateTime messageDate;
  final String messageTime;
  final String ProfileImage;

  const MessageData({this.SenderName, this.message, this.messageDate, this.messageTime, this.ProfileImage});


}