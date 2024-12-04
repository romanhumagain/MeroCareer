import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class EducationDetailsData extends StatelessWidget {
  const EducationDetailsData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EducationDetailsTimeLine(
              degreeName: "Under Graduate",
              instituteName: "University of Bedfordshire",
              educationProgram: "Software Engineering",
              date: "Dec, 2022 - Dec, 2025",
              isDarkMode: isDarkMode),
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
    );
  }
}

class EducationDetailsTimeLine extends StatelessWidget {
  final String date;
  final String degreeName;
  final String instituteName;
  final String educationProgram;
  final bool isDarkMode;

  const EducationDetailsTimeLine({
    super.key,
    required this.degreeName,
    required this.instituteName,
    required this.educationProgram,
    required this.date,
    required this.isDarkMode,
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
                  degreeName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  educationProgram,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  instituteName,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade700,
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
