import 'package:flutter/material.dart';

Future<bool> showCustomConfirmationDialog(
    BuildContext context, String message) async {
  final bool? result = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
      return AlertDialog(
        title: Text("Confirm"),
        content: Text(message),
        backgroundColor:
            isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
