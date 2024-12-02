import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/preference_info_table.dart';
import 'package:provider/provider.dart';

class JobPreference extends StatelessWidget {
  const JobPreference({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Job Preference",
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
                height: 14,
              ),
              PreferenceInfoTable(
                  data: "Prefered Job Title",
                  value: "Backend Developer",
                  size: size),
              SizedBox(
                height: 8,
              ),
              PreferenceInfoTable(
                  data: "Prefered Job Level", value: "Entry Level", size: size),
              SizedBox(
                height: 8,
              ),
              PreferenceInfoTable(
                  data: "Expected Salary",
                  value: "NRs 20000 Monthly",
                  size: size),
              SizedBox(
                height: 8,
              ),
              PreferenceInfoTable(
                  data: "Prefered Job Location",
                  value: "Kathmandu",
                  size: size),
              SizedBox(
                height: 8,
              ),
              PreferenceInfoTable(
                  data: "Prefered Job Category",
                  value: "IT & Telecommunication",
                  size: size),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
