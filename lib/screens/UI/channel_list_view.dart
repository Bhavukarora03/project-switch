import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../../Translations.dart';
import 'messages_page.dart';

class channelList extends StatefulWidget {
  const channelList({Key key}) : super(key: key);

  @override
  State<channelList> createState() => _channelListState();
}

class _channelListState extends State<channelList> {
  StreamChannelListController listController;

  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listController =
        StreamChannelListController(client: StreamChat.of(context).client);

    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("title")),
        ),
        body: StreamChannelListView(
          controller: listController,
          onChannelTap: (channel) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return StreamChannel(child: MessagesPage(), channel: channel);
            }));
          },
        ));
  }
}
