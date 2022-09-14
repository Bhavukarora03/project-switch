

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:project_switch/app.dart';
import 'package:project_switch/helper.dart';
import 'package:project_switch/models/models.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'package:project_switch/UI/screens/screens.dart';

import '../../widgets/widgets.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final channelListController = StreamChannelListController(
    client: StreamChatCore.of(context).client,
    filter: Filter.and([
      Filter.equal('type', 'messaging'),
      Filter.in_(
        'members',
        [
          StreamChatCore.of(context).currentUser!.id,
        ],
      ),
    ]),
  );

  @override
  void initState() {
    channelListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedValueListenableBuilder<int, Channel>(
        // child:  CustomScrollView(
        //   slivers: [SliverToBoxAdapter(
        //       child: _Stories()
        //   ),],
        // ),
        valueListenable: channelListController,
        builder: (context, value, child) {
          return value.when(
            (channels, nextPageKey, error) => LazyLoadScrollView(
                onEndOfPage: () async {
                  if (nextPageKey != null) {
                    channelListController.loadMore(nextPageKey);
                  }
                },
                child: ListView.builder(
                  itemCount: (nextPageKey != null || error != null)
                      ? channels.length + 1
                      : channels.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == channels.length) {
                      if (error != null) {
                        return TextButton(
                          onPressed: () {
                            channelListController.retry();
                          },
                          child: Text(error.message),
                        );
                      }
                      return CircularProgressIndicator();
                    }

                    final _item = channels[index];
                    return _MessageTile(channel: channels[index]);
                  },
                )),
            loading: () => const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e) => Center(
                child: DisplayErrorMessage(
              error: e,
            )),
          );
        },
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.channel}) : super(key: key);

  final Channel channel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(ChatScreen.routeWithChannel(channel));
            },
            minVerticalPadding: 10,
            leading: Avatar.medium(
              url: Helpers.getChannelImage(channel, context.currentUser!),
            ),
            title: Text(
                '${Helpers.getChannelName(channel, context.currentUser!)}'),
            subtitle: _BuildLastMessage(),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
               _BuildLastMessageAt(),

               UnreadIndicatorText(channel: channel),
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

  Widget _BuildLastMessage() {
    return BetterStreamBuilder<int>(
        stream: channel.state!.unreadCountStream,
        initialData: channel.state!.unreadCount,
        builder: (context, count) {
          return BetterStreamBuilder<Message>(
              stream: channel.state!.lastMessageStream,
              initialData: channel.state!.lastMessage,
              builder: (context, message) {
                if (message == null) {
                  return const SizedBox.shrink();
                }
                return Text(
                  message.text!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (count > 0) ? const TextStyle(color: Colors.green) : const TextStyle(color: Colors.white),
                );
              });
        });
  }

  Widget _BuildLastMessageAt() {
    return BetterStreamBuilder<DateTime>(
        initialData: channel.lastMessageAt,
        stream: channel.lastMessageAtStream,
        builder: (conetext, data) {
          final lastMessageAt = data.toLocal();
          String stringDate;
          final now = DateTime.now();

          final startOfDay = DateTime(now.year, now.month, now.day);

          if (lastMessageAt.millisecond >= startOfDay.millisecondsSinceEpoch) {
            stringDate = Jiffy(lastMessageAt.toLocal()).format("hh:mm a");
          } else if (lastMessageAt.millisecondsSinceEpoch >=
              startOfDay
                  .subtract(const Duration(days: 1))
                  .millisecondsSinceEpoch) {
            stringDate = "Yesterday";
          } else if (startOfDay.difference(lastMessageAt).inDays <= 7) {
            stringDate = Jiffy(lastMessageAt).EEEE;
          } else {
            stringDate = Jiffy(lastMessageAt).yMMMMd;
          }
          return Text("$stringDate");
        });
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

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
            const Padding(
              padding: EdgeInsets.all(10.0),
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
  const _StoryCard({Key? key, required this.storyData}) : super(key: key);
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
