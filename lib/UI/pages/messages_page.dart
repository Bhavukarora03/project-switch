import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:project_switch/UI/screens/chat_screen.dart';
import 'package:project_switch/helper.dart';
import 'package:project_switch/models/models.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../widgets/widgets.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _Stories()),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delagtes),
        )
      ],
    );
  }

  Widget _delagtes(BuildContext context, int index) {
    final faker = Faker();
    final date = Helpers.randomDate();
    return _MessageTile(
      messageData: MessageData(
        senderName: faker.person.name(),
        message: faker.lorem.sentence(),
        messageDate: date,
        messageTime: Jiffy(date).fromNow(),
        profileImage: Helpers.randomURL(),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key key, this.messageData}) : super(key: key);

  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(ChatScreen.route(messageData));
            },
            minVerticalPadding: 10,
            leading: Avatar.medium(
              url: messageData.profileImage,
            ),
            title: Text(messageData.senderName),
            subtitle: Text(
              messageData.message,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(messageData.messageTime),
                Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Text("1"))),
              ],
            ),
          ),
          const Divider(
            color: Colors.white12,
            indent: 1,
            endIndent: 1,
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: SizedBox(
        height: 134,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Stories"),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final faker = Faker();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 60,
                      child: _StoryCard(
                        storyData: StoryData(
                          name: faker.person.name(),
                          url: Helpers.randomURL(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key key, this.storyData}) : super(key: key);
  final StoryData storyData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(
          url: storyData.url,
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  storyData.name,
                  overflow: TextOverflow.ellipsis,
                ))),
      ],
    );
  }
}
