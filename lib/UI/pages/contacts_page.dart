import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_switch/widgets/avatar.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../screens/chat_screen.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final userListController = StreamUserListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and(
      [Filter.notEqual('id', StreamChat.of(context).currentUser!.id)],
    ),
    sort: [
      const SortOption(
        'name',
        direction: 1,
      ),
    ],
  );
  @override
  void initState() {
    userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    userListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedValueListenableBuilder<int, User>(
      valueListenable: userListController,
      builder: (context, value, child) {
        return value.when(
          (users, nextPageKey, error) => LazyLoadScrollView(
            onEndOfPage: () async {
              if (nextPageKey != null) {
                userListController.loadMore(nextPageKey);
              }
            },
            child: ListView.builder(
              itemCount: (nextPageKey != null || error != null)
                  ? users.length + 1
                  : users.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == users.length) {
                  if (error != null) {
                    return TextButton(
                      onPressed: () {
                        userListController.retry();
                      },
                      child: Text(error.message),
                    );
                  }
                  return CircularProgressIndicator();
                }

                final _item = users[index];
                return _ContactTile(item: _item);
              },
            ),
          ),
          loading: () => const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e) => Center(
            child: Text(
              'Oh no, something went wrong. '
              'Please check your config. $e',
            ),
          ),
        );
      },
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    Key? key,
    required User item,
  })  : item = item,
        super(key: key);

  final User item;

  Future<void> createChannel(BuildContext context) async {
    final _client = StreamChat.of(context);
    final channel = _client.client.channel(
      'messaging',
      extraData: {
        'members': [_client.currentUser!.id, item.id]
      },
    );
    await channel.create();
    await channel.watch();
    Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){ createChannel(context);},
      title: Text(item.name),
      leading: Avatar.medium(
        url: item.image,
      ),
    );
  }
}
