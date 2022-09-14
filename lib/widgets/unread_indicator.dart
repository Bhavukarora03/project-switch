import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class UnreadIndicatorText extends StatelessWidget {

  const UnreadIndicatorText({
    Key? key,
    required this.channel,
  }) : super(key: key);

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BetterStreamBuilder<int>(
        stream: channel.state!.unreadCountStream,
        initialData: channel.state!.unreadCount,
        builder: (context, data) {
          if (data == 0) {
            return const SizedBox();
          }
          return Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(50),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${data > 99 ? '99+' : data}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}