import 'dart:math';

import 'package:stream_chat/stream_chat.dart';

abstract class Helpers {
  static String randomURL() {
    final randomInt = Random().nextInt(100);
    return "https://picsum.photos/seed/$randomInt/200/200";
  }

  static DateTime randomDate() {
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }

  static String? getChannelImage(Channel channel, User currentUser) {
    if (channel.image != null) {
      return channel.image;
    } else if (channel.state!.members.isNotEmpty) {
      final members = channel.state!.members
          .where((element) => element.user!.id != currentUser.id)
          .toList();
      if (members.length == 1) {
        return members.first.user!.image;
      } else {
        return null;
      }
    }
    return null;
  }

  static String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) {
      return channel.name!;
    } else if (channel.state!.members.isNotEmpty) {
      final members = channel.state!.members
          .where((element) => element.user!.id != currentUser.id)
          .toList();
      if (members.length == 1) {
        return members.first.user!.name;
      } else {
        return members.map((e) => e.user!.name).join(', ');
      }
    }
 return '';
  }
}