import 'package:flutter/material.dart';
import 'package:mero_career/providers/chat_provider.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:provider/provider.dart';

class ChatDetails extends StatefulWidget {
  final int chatRoomId;
  final String name;
  final String imageUrl;

  const ChatDetails({
    super.key,
    required this.chatRoomId,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<ChatDetails> createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  TextEditingController messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllChatMessages();
    });
  }

  void getAllChatMessages() async {
    await Provider.of<ChatProvider>(context, listen: false)
        .fetchAllMessages(widget.chatRoomId);

    await Provider.of<ChatProvider>(context, listen: false)
        .markAllMessageRead({'room_id': widget.chatRoomId});

    _scrollToBottom();
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      final response = await Provider.of<ChatProvider>(context, listen: false)
          .sendMessage(widget.chatRoomId, {'content': messageController.text});
      messageController.clear();

      if (response?.statusCode == 201) {
        await Provider.of<ChatProvider>(context, listen: false).getChatRoom();
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.imageUrl != null
                  ? NetworkImage(widget.imageUrl)
                  : AssetImage('assets/images/avatar1.png') as ImageProvider,
              radius: 12,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 20.5),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 14.5, right: 14.5, top: 14.5, bottom: 100),
            child: Consumer<ChatProvider>(builder: (context, provider, child) {
              final chatDetails = provider.chatDetails;
              if (chatDetails!.isEmpty) {
                return SizedBox();
              }
              return ListView.builder(
                controller: _scrollController, // Use ScrollController here
                itemCount: chatDetails.length,
                itemBuilder: (context, index) {
                  return Chat(
                    chat: chatDetails[index],
                    size: size,
                  );
                },
              );
            }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.grey.shade900
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade500,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade500,
                          ),
                        ),
                        hintText: "Type your message",
                        hintStyle:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                  color: Colors.grey,
                                ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Chat extends StatelessWidget {
  final Map<String, dynamic> chat;
  final Size size;

  const Chat({super.key, required this.size, required this.chat});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: chat['is_sent_by_me']
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              width: size.width / 2,
              decoration: BoxDecoration(
                  color: chat['is_sent_by_me']
                      ? Colors.blue
                      : (isDarkMode
                          ? Colors.grey.shade900
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(18)),
              child: Text(
                chat['content'],
                style: TextStyle(
                    color: chat['is_sent_by_me']
                        ? Colors.white
                        : (isDarkMode
                            ? Colors.grey.shade300
                            : Colors.grey.shade800),
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            chat['is_sent_by_me']
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        Text(
                          formatChatTime(chat['timestamp']),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 12.6),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.done_all,
                          color: Colors.blue,
                          size: 20,
                        )
                      ],
                    ),
                  )
                : Text("")
          ],
        )
      ],
    );
  }
}
