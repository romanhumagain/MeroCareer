import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class EducationDetails extends StatelessWidget {
  const EducationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Education Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 19, letterSpacing: 0.2),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 26,
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Column(
            children: [
              Padding(
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
                    SizedBox(width: 16),

                    EducationDetailsTimeLine(isDarkMode: isDarkMode),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class EducationDetailsTimeLine extends StatelessWidget {
  const EducationDetailsTimeLine({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bachelor of Computer Science",
          style: TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        // Institution Name
        Text(
          "University of Bedfordshire",
          style: TextStyle(
            fontSize: 14,
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 5),
        // Duration
        Text(
          "2020 - 2024",
          style: TextStyle(
            fontSize: 13,
            color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
