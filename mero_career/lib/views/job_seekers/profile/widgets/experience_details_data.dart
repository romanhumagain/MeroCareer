import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class ExperienceDetailsData extends StatelessWidget {
  const ExperienceDetailsData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExperienceTimeline(
                date: "Dec 2020 - Now",
                jobTitle: "Backend Developer",
                industryName: "Cedar Gate Technology",
                role: "Developer",
              ),
              Row(
                children: [
                  Text(
                    'Delete',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blueAccent, fontSize: 17),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blueAccent, fontSize: 17),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ExperienceTimeline extends StatelessWidget {
  final String date;
  final String jobTitle;
  final String industryName;
  final String role;

  const ExperienceTimeline({
    super.key,
    required this.date,
    required this.jobTitle,
    required this.industryName,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 60,
                  color: Colors.blue.shade400,
                ),
              ],
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  industryName,
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
