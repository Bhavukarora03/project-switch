import 'package:flutter/material.dart';
import 'package:project_switch/api/api_keys.dart';
import 'package:project_switch/screens/UI/material_app.dart';
import 'package:stream_chat/stream_chat.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(apiKey,);
  await client.connectUser(User(id: 'project-Switch'), clientToken);
  final channel = client.channel('messaging', id: "1205919");

  await channel.watch();

  runApp(MyApp(
    channel: channel,
    client: client,
  ));
}
