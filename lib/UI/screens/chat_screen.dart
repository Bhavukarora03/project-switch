import 'package:flutter/material.dart';
import 'package:project_switch/models/models.dart';
import 'package:project_switch/widgets/widgets.dart';


class ChatScreen extends StatelessWidget {
  static Route route(MessageData data) {
    return MaterialPageRoute(
      builder: (context) => ChatScreen(
        messageData: data,
      ),
    );
  }

  const ChatScreen({Key key, this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () {},
              icon: const  Icon(Icons.video_call),
            )
          ],
          toolbarHeight: 100,
          centerTitle: true,
          title: _AppBarTitle(
            messageData: messageData,
          ),
        ),
        body: Column(
          children: const [
            Expanded(child: _MessageList()), Padding(
            padding:  EdgeInsets.only(bottom: 12.0),
            child: _ActionBar(),
          )],
        ));
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: const [
          _Datelabel(
            label: "Today",
          ),
          _MessageTile(
            message: "Hello this is a sample",
            messageTime: "12:30",
          ),
          _MessageOwnTile(
            message: "ABc",
            messageTime: "123",
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key key, this.message, this.messageTime})
      : super(key: key);

  final String message;
  final String messageTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(26),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 12.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageTime,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageOwnTile extends StatelessWidget {
  const _MessageOwnTile({Key key, this.message, this.messageTime})
      : super(key: key);
  final String message;
  final String messageTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 12.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageTime,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Datelabel extends StatelessWidget {
  const _Datelabel({Key key, this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ));
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({Key key, this.messageData}) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        messageData.senderName,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Avatar.medium(url: messageData.profileImage),
      subtitle: Text(
        'Online',
        style: TextStyle(color: Colors.green.shade500),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 16),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_rounded)),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 24.0),
            child: GlowingActionButton(
              onPressed: () {},
              icon: Icons.send_outlined,
              color: Colors.deepOrange.shade900,
            ),
          )
        ],
      ),
    );
  }
}
