import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePreviewHeading extends StatefulWidget {
  const ProfilePreviewHeading({super.key});

  @override
  State<ProfilePreviewHeading> createState() => _ProfilePreviewHeadingState();
}

class _ProfilePreviewHeadingState extends State<ProfilePreviewHeading> {
  // Current status of the job application
  String _jobStatus = "Under Review";

  // Status options
  final List<String> _statusOptions = [
    "Under Review",
    "Accepted",
    "Rejected",
    "Shortlisted",
  ];

  void _openStatusModal(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.edit_note,
                size: 24,
                color: Colors.blue.shade300,
              ),
              SizedBox(width: 8), // Spacing between icon and text
              Text(
                "Change Job Status",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          backgroundColor:
              isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _statusOptions.map((status) {
                return RadioListTile<String>(
                  title: Text(status),
                  value: status,
                  groupValue: _jobStatus,
                  onChanged: (newStatus) {
                    setState(() {
                      _jobStatus = newStatus!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/images/pp.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Roman Humagain",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18),
                  ),
                  Text(
                    "romanhumagain@gmail.com",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 13.5, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16.5,
                            color: Colors.grey,
                          ),
                          Text(
                            "Bhaktapur",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16.5,
                            color: Colors.grey,
                          ),
                          Text(
                            "9840617105",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () => _openStatusModal(context), // Open the modal dialog
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                _jobStatus,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
