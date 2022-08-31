import 'package:flutter/material.dart';
import 'package:project_switch/Translations.dart';
import 'package:project_switch/screens/UI/home_screen.dart';


import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';

import 'channel_list_view.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key key, this.client, this.channel}) : super(key: key);

  final StreamChatClient client;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
      locale: Locale('hi'),
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('fr'),
        Locale('it'),
        Locale('es'),
        Locale('ja'),
        Locale('ko'),
        Locale('pt'),
        Locale('de'),
        Locale('no'),
      ],
      localizationsDelegates: const [TranslationsDelegate(),...GlobalStreamChatLocalizations.delegates],

    );
  }
}
