import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/providers/job_provider.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

class ProfilePreviewHeading extends StatefulWidget {
  final String role;
  final Map<String, dynamic> profileData;
  final int applicantId;

  const ProfilePreviewHeading({
    super.key,
    required this.profileData,
    required this.role,
    required this.applicantId,
  });

  @override
  State<ProfilePreviewHeading> createState() => _ProfilePreviewHeadingState();
}

class _ProfilePreviewHeadingState extends State<ProfilePreviewHeading> {
  String _jobStatus = "Under Review";

  final List<String> _statusOptions = [
    "Under Review",
    "Reviewed",
    "Accepted",
    "Rejected",
    "Shortlisted",
  ];

  final Map<String, Color> _statusColors = {
    "Under Review": Colors.blue.shade300,
    "Reviewed": Colors.teal.shade300,
    "Accepted": Colors.green.shade400,
    "Rejected": Colors.red.shade400,
    "Shortlisted": Colors.orange.shade400,
  };

  @override
  void initState() {
    super.initState();
    final provider = context.read<JobProvider>();
    final applicantDetails = provider.applicantDetails;

    if (applicantDetails != null && applicantDetails.containsKey('status')) {
      setState(() {
        _jobStatus = applicantDetails['status'] ?? "Under Review";
      });
    }
  }

  void _showConfirmationDialog(BuildContext context, String newStatus) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Confirm Status Change",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Text(
            "Are you sure you want to change the status to '$newStatus'?",
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor:
              isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateJobStatus(newStatus);
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _updateJobStatus(String newStatus) async {
    final provider = context.read<JobProvider>();
    setState(() {
      _jobStatus = newStatus;
    });

    await provider.updateApplicantDetails(
      widget.applicantId,
      {"status": newStatus},
    );
  }

  void _openStatusModal(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Change Job Status",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    Navigator.of(context).pop();
                    _showConfirmationDialog(context, newStatus!);
                  },
                );
              }).toList(),
            ),
          ),
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
          child: Consumer<JobProvider>(builder: (context, provider, child) {
            final Map<String, dynamic>? applicantDetails =
                provider.applicantDetails;
            if (applicantDetails!.isEmpty) {
              return Text("N/A");
            }
            return Text(
              applicantDetails['status'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            );
          })),
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

    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        final Map<String, dynamic>? _applicantDetails =
            provider.applicantDetails;
        if (_applicantDetails!.isEmpty) {
          return const Text("No applicants data found!");
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                                ?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16.5, color: Colors.grey),
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
                              const Icon(Icons.phone,
                                  size: 16.5, color: Colors.grey),
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
                  ),
                  widget.role == "recruiter"
                      ? _buildJobStatusBadge()
                      : const SizedBox(),
                ],
              ),
              widget.role == "recruiter"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyDivider(),
                        const SizedBox(height: 10),
                        Text(
                          "Applied For: ${_applicantDetails['job_title']}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Applied: ${formatSavedAt(_applicantDetails['applied_on'])}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontSize: 14),
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
