import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
            ChatList(
              profileImageUrl: 'assets/images/image.jpg',
              senderName: "Anuj Gautam",
              lastMessage: "Whats up bro? what are you doing?",
              date: "20 Jan",
              hasRead: true,
            ),
            ChatList(
              profileImageUrl: 'assets/images/pp.jpg',
              senderName: "Pratap Yadav",
              lastMessage: "Whats up bro? what are you doing?",
              date: "16 Nov",
              hasRead: true,
            ),
            ChatList(
              profileImageUrl: 'assets/images/pp.jpg',
              senderName: "Prashanna Humagain",
              lastMessage: "Whats up bro?",
              date: "19 Dec",
              hasRead: true,
            ),
            ChatList(
              profileImageUrl: 'assets/images/image.jpg',
              senderName: "Gaurav K.C",
              lastMessage: "Whats up bro? what are you doing?",
              date: "20 Jan",
              hasRead: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  final String profileImageUrl;
  final String senderName;
  final String lastMessage;
  final String date;
  final bool hasRead;

  const ChatList({
    super.key,
    required this.profileImageUrl,
    required this.senderName,
    required this.lastMessage,
    required this.date,
    required this.hasRead,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatDetails()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.2),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(profileImageUrl),
          ),
          title: Text(
            senderName,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 16.5),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  lastMessage,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.tertiary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(date),
              )
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 17.5,
          ),
        ),
      ),
    );
  }
}
