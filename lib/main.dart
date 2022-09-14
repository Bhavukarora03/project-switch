import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_switch/api/api_keys.dart';
import 'package:project_switch/firebase_options.dart';
import 'package:stream_chat/stream_chat.dart';
import 'UI/pages/material_app.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final client = StreamChatClient(apiKey);
  // await client.connectUser(User(id: 'project-Switch'), clientToken);
  // final channel = client.channel('messaging', id: "1205919");

  // await channel.watch();

  runApp(MyApp(
    client: client,
  ));
}
