import 'package:flutter/material.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class WorkExperience extends StatelessWidget {
  final List<dynamic> data;

  const WorkExperience({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Work Experience",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 19, letterSpacing: 0.2),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              children: data.map((experience) {
                return ExperienceTimeline(
                  date:
                      "${formatEduDate(experience['start_date'])} - ${experience['end_date'] != null ? formatEduDate(experience['end_date']) : "Now"}",
                  jobTitle: experience['job_title'] ?? "N/A",
                  industryName: experience['institute_name'] ?? "N/A",
                  role: experience['job_role'] ?? "N/A",
                );
              }).toList(),
            ),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  industryName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4),
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
