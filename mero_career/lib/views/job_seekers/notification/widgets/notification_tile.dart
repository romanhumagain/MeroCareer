import 'package:flutter/material.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class NotificationTile extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    Color readColor = isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200;
    Color unreadColor =
        isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300;

    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: size.width,
          decoration: BoxDecoration(
            color: notification['is_read'] ? readColor : unreadColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: notification['profile_image'] != null
                      ? Image.network(
                          notification['profile_image'],
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          notification['profile_image'],
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )),
              const SizedBox(width: 12), // Spacing between image and text
              // Notification Text and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Notification Message
                    Text(
                      notification['message'],
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6), // Spacing
                    // Date
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        formatPostedDate(notification['created_at']),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Optional Icon (e.g., status indicator or arrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: isDarkMode ? Colors.white : Colors.black54,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
