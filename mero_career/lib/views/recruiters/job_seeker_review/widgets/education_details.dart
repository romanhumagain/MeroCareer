import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../utils/date_formater.dart';

class EducationDetails extends StatelessWidget {
  final List<dynamic> data;

  const EducationDetails({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              Text(
                "Education Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 19, letterSpacing: 0.2),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 26,
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Education Timeline
          Column(
            children: data.map((education) {
              return EducationTimelineItem(
                isDarkMode: isDarkMode,
                degree: education['degree_type'] ?? "N/A",
                institution: education['institute_name'] ?? "N/A",
                duration:
                    "${formatEduDate(education['start_date'])} - ${education['end_date'] != null ? formatEduDate(education['end_date']) : "Now"}",
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class EducationTimelineItem extends StatelessWidget {
  final bool isDarkMode;
  final String degree;
  final String institution;
  final String duration;

  const EducationTimelineItem({
    super.key,
    required this.isDarkMode,
    required this.degree,
    required this.institution,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Indicator (Circle and Line)
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
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
          const SizedBox(width: 16),

          // Education Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Degree Name
              Text(
                degree,
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              // Institution Name
              Text(
                institution,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 5),
              // Duration
              Text(
                duration,
                style: TextStyle(
                  fontSize: 13,
                  color:
                      isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
