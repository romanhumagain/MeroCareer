import 'package:flutter/material.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        centerTitle: false,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/image.jpg'),
              radius: 16,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Roman Humagain",
              style: TextStyle(fontSize: 20.5),
            )
          ],
        ),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert_rounded),
              onSelected: (String value) {
                if (value == 'delete') {
                } else if (value == 'archive') {}
              },
              onCanceled: () {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 10),
                        Text('Delete'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'archive',
                    child: Row(
                      children: const [
                        Icon(Icons.archive, color: Colors.blue),
                        SizedBox(width: 10),
                        Text('Archive'),
                      ],
                    ),
                  ),
                ];
              })
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.5),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Chat(
                    size: size,
                    message: "Hello bro, how are you ?",
                    sentDate: "28 Nov",
                    isSentByMe: true,
                  ),
                  Chat(
                    size: size,
                    message: "Fine bro... What about you?",
                    sentDate: "28 Nov",
                    isSentByMe: false,
                  ),
                  Chat(
                    size: size,
                    message: "Have you finished your assignment?",
                    sentDate: "28 Nov",
                    isSentByMe: false,
                  ),
                  Chat(
                    size: size,
                    message: "No bro, I am working on it.",
                    sentDate: "28 Nov",
                    isSentByMe: true,
                  ),
                  Chat(
                    size: size,
                    message: "I will inform you after completing.",
                    sentDate: "28 Nov",
                    isSentByMe: true,
                  ),
                  Chat(
                    size: size,
                    message: "OKEY... see you soon!",
                    sentDate: "28 Nov",
                    isSentByMe: false,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(0)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
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
                  Icon(
                    Icons.send,
                    color: Colors.blue,
                    size: 28,
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
  final bool isSentByMe;
  final String message;
  final String sentDate;
  final Size size;

  const Chat({
    super.key,
    required this.size,
    required this.isSentByMe,
    required this.message,
    required this.sentDate,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: size.width / 2,
              decoration: BoxDecoration(
                  color: isSentByMe
                      ? Colors.blue
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(18)),
              child: Text(
                message,
                style: TextStyle(
                    color: isSentByMe
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
            isSentByMe
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        Text(
                          sentDate,
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
