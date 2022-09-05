import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_switch/UI/screens/screens.dart';
import 'package:project_switch/app.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static Route get route =>
      MaterialPageRoute(builder: (context) =>  const ProfileScreen());

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero-profile-image',
              child: Avatar.large(
                url: user!.image,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(user.name),
            ),
            const _SignOutButton()
          ],
        ),
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({Key? key}) : super(key: key);

  @override
  State<_SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<_SignOutButton> {
  bool loading = false;
  Future<void> _signOut() async {
    setState(
      () {
        loading = true;
      },
    );
    try {
      final client = StreamChat.of(context).client;
      await client.disconnectUser();
      Get.off(() =>  const SelectUsersScreen());
    } on Exception catch (e) {
      logger.e(e);
      setState(
        () {
          loading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: _signOut, child: const Text("Sign out"));
  }
}
