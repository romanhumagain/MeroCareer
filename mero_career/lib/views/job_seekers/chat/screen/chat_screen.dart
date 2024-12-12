import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mero_career/providers/chat_provider.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_details.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getChatRooms();
    });
  }

  void _getChatRooms() async {
    await Provider.of<ChatProvider>(context, listen: false).getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chats",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(
              height: 6,
            ),
            Consumer<ChatProvider>(
              builder: (context, provider, child) {
                final chatRooms = provider.chatRooms;
                if (chatRooms!.isEmpty) {
                  return Text(
                    "No recent chat found. ",
                    style: TextStyle(fontSize: 18),
                  );
                }
                return Column(
                  children: chatRooms.map((chatRoom) {
                    return ChatList(
                      chatRoom: chatRoom,
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final Map<String, dynamic> chatRoom;

  const ChatList({
    super.key,
    required this.chatRoom,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    Color unreadColor =
        isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;
    Color readColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetails(
                      chatRoomId: chatRoom['id'],
                      name: chatRoom['sender_name'],
                      imageUrl: chatRoom['profile_image'],
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
              color: chatRoom['is_unread'] ? unreadColor : readColor,
              borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: chatRoom['profile_image'] != null
                  ? NetworkImage("${chatRoom['profile_image']}")
                  : AssetImage('assets/images/default_profile.png')
                      as ImageProvider,
            ),
            title: Expanded(
              child: Text(
                chatRoom['sender_name'],
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 17),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    chatRoom['last_message'],
                    style: TextStyle(
                        color: chatRoom['is_unread']
                            ? Theme.of(context).colorScheme.onBackground
                            : Theme.of(context).colorScheme.tertiary,
                        fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${formatSavedAt(chatRoom['last_message_date'])}",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: chatRoom['is_unread'] ? Colors.blue : Colors.grey,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
