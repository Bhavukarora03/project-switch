import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'screens.dart';


class SelectUsersScreen extends StatefulWidget {
  const SelectUsersScreen({Key? key}) : super(key: key);

  static Route get route {
    return MaterialPageRoute(builder: (context) =>  const SelectUsersScreen());
  }

  @override
  State<SelectUsersScreen> createState() => _SelectUsersScreenState();
}

class _SelectUsersScreenState extends State<SelectUsersScreen> {
  late StreamChatCore streamChatCore;
  late StreamChannelListController channelListController;

  bool _loading = false;

  Future<void> onUsersSelected(Users user) async {
    setState(() {
      _loading = true;
    });
    try {
      final client = StreamChat.of(context).client;
      //await client.disconnectUser();
      await client.connectUser(
          User(
              id: user.id, extraData: {'name': user.name, 'image': user.image}),
          client.devToken(user.id).rawValue);

      Get.off(() =>  const HomeScreen());
    } on Exception catch (e) {

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Select user"), automaticallyImplyLeading: false,),
      body: (_loading)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return SelectedUserButton(
                  user: users[index],
                  onPressed: onUsersSelected,
                );
              }),
    );
  }
}

class SelectedUserButton extends StatelessWidget {
  const SelectedUserButton({Key? key, required this.onPressed, required this.user})
      : super(key: key);
  final Function(Users user) onPressed;
  final Users user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar.medium(url: user.image),
      title: Text(user.name),
      onTap: () => onPressed(user),
    );
  }
}
