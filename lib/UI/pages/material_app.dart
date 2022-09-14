import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project_switch/Translations.dart';
import 'package:project_switch/UI/screens/select_users.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_localizations/stream_chat_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.client,}) : super(key: key);

  final StreamChatClient client;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return StreamChat(client: client, child: child);
        },
        home: const SelectUsersScreen(),
        locale: const Locale('en'),
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
        localizationsDelegates: const [
          TranslationsDelegate(),
          ...GlobalStreamChatLocalizations.delegates
        ],


        );
  }
}
