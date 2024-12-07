import 'package:flutter/material.dart';
import 'package:mero_career/services/profile_setup_services.dart';
import 'package:provider/provider.dart';

import '../../../../providers/profile_setup_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/date_formater.dart';
import '../../../widgets/custom_confirmation_message.dart';

class ExperienceDetailsData extends StatelessWidget {
  const ExperienceDetailsData({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Consumer<ProfileSetupProvider>(builder: (context, provider, child) {
      final List? experienceDetails = provider.experienceDetails;
      final bool isLoading = provider.isLoading;

      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDarkMode ? Colors.white : Colors.blue,
                  ),
                ),
              )
            else if (experienceDetails != null && experienceDetails.isNotEmpty)
              ...experienceDetails.map((detail) {
                return ExperienceTimeline(
                  experience: detail,
                );
              })
            else
              Text(
                "No Experience details added yet.",
                style: TextStyle(
                  fontSize: 17,
                  color: isDarkMode ? Colors.white : Colors.black54,
                ),
              ),
          ],
        ),
      );
    });
  }
}

class ExperienceTimeline extends StatelessWidget {
  final Map<String, dynamic> experience;

  const ExperienceTimeline({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    void _handleExperienceDelete() async {
      bool isConfirmed = await showCustomConfirmationDialog(context,
          "Are you sure you want to delete this experience details ? This action cannot be undone !");
      if (isConfirmed) {
        Provider.of<ProfileSetupProvider>(context, listen: false)
            .deleteExperienceDetails(context, experience['id']);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${formatEduDate(experience['start_date']) ?? ''} - ${experience['is_currently_working'] ? 'Now' : formatEduDate(experience['end_date'])}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
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
                          experience['job_title'],
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
                          experience['institute_name'],
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
                          experience['job_role'],
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
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _handleExperienceDelete();
                },
                child: Text(
                  'Delete',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.blueAccent, fontSize: 17),
                ),
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
