import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfilePreviewHeading extends StatefulWidget {
  final String role;
  final Map<String, dynamic> profileData;

  const ProfilePreviewHeading(
      {super.key, required this.profileData, required this.role});

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

  // Map for badge colors based on job status
  final Map<String, Color> _statusColors = {
    "Under Review": Colors.blue.shade300,
    "Accepted": Colors.green.shade400,
    "Rejected": Colors.red.shade400,
    "Shortlisted": Colors.orange.shade400,
  };

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
              const SizedBox(width: 8), // Spacing between icon and text
              const Text(
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
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildJobStatusBadge() {
    return GestureDetector(
      onTap: () => _openStatusModal(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: _statusColors[_jobStatus] ?? Colors.blue.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _jobStatus,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = widget.profileData['profile_image'] ??
        'https://via.placeholder.com/150';
    final fullName = widget.profileData['full_name'] ?? 'Unknown';
    final email = widget.profileData['email'] ?? 'N/A';
    final location = widget.profileData['address'] ?? 'Unknown';
    final phoneNumber = widget.profileData['phone_number'] ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(profileImage),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18),
                  ),
                  Text(
                    email,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 13.5, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16.5,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            size: 16.5,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            phoneNumber,
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
          widget.role == "recruiter" ? _buildJobStatusBadge() : SizedBox(),
        ],
      ),
    );
  }
}
