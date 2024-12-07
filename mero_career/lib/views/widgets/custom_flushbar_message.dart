import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum MessageType { success, error, warning }

void showCustomFlushbar({
  required BuildContext context,
  required String message,
  required MessageType type,
}) {
  IconData iconData;
  Color backgroundColor;
  List<Color> gradientColors;

  switch (type) {
    case MessageType.success:
      iconData = Icons.check_circle;
      backgroundColor = Colors.green;
      gradientColors = [Colors.green.shade800, Colors.green.shade600];
      break;
    case MessageType.error:
      iconData = Icons.error;
      backgroundColor = Colors.red;
      gradientColors = [Colors.red.shade800, Colors.red.shade600];
      break;
    case MessageType.warning:
      iconData = Icons.warning_amber_rounded;
      backgroundColor = Colors.orange;
      gradientColors = [Colors.orange.shade800, Colors.orange.shade600];
      break;
  }

  // Show Flushbar
  Flushbar(
    message: message,
    icon: Icon(
      iconData,
      size: 28.0,
      color: Colors.white,
    ),
    duration: Duration(milliseconds: 800),
    margin: EdgeInsets.all(12),
    padding: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(12),
    backgroundGradient: LinearGradient(colors: gradientColors),
    boxShadows: [
      BoxShadow(
        color: gradientColors.first.withOpacity(0.3),
        offset: Offset(0, 3),
        blurRadius: 8,
      ),
    ],
    flushbarPosition: FlushbarPosition.TOP,
    title: type.name.toUpperCase(),
    titleText: Text(
      type.name.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    messageText: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  ).show(context);
}
