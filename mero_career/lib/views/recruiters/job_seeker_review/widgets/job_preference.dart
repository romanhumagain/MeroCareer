import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/preference_info_table.dart';
import 'package:provider/provider.dart';

class JobPreference extends StatelessWidget {
  final Map<String, dynamic> data;
  final Size size;

  const JobPreference({
    super.key,
    required this.size,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeProvider>().isDarkMode;

    // List of job preference data for better scalability
    final preferences = [
      {
        'label': 'Preferred Job Title',
        'value': data['jobTitle'] ?? 'Backend Developer'
      },
      {
        'label': 'Preferred Job Level',
        'value': data['jobLevel'] ?? 'Entry Level'
      },
      {
        'label': 'Expected Salary',
        'value': data['expectedSalary'] ?? 'NRs 20000 Monthly'
      },
      {
        'label': 'Preferred Job Location',
        'value': data['jobLocation'] ?? 'Kathmandu'
      },
      {
        'label': 'Preferred Job Category',
        'value': data['jobCategory'] ?? 'IT & Telecommunication'
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Text(
                    "Job Preference",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 19, letterSpacing: 0.2),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.keyboard_arrow_down_outlined, size: 26),
                ],
              ),
              const SizedBox(height: 14),

              // Preferences List
              ...preferences.map((preference) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: PreferenceInfoTable(
                      data: preference['label']!,
                      value: preference['value']!,
                      size: size,
                    ),
                  )),

              // Ensure spacing at the bottom
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
