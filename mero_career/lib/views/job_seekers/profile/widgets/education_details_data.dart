import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/widgets/custom_confirmation_message.dart';
import 'package:provider/provider.dart';

import '../../../../utils/date_formater.dart';

class EducationDetailsData extends StatefulWidget {
  const EducationDetailsData({super.key});

  @override
  State<EducationDetailsData> createState() => _EducationDetailsDataState();
}

class _EducationDetailsDataState extends State<EducationDetailsData> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Consumer<ProfileSetupProvider>(
      builder: (context, provider, child) {
        final List? educationDetails = provider.educationDetails;
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
              else if (educationDetails != null && educationDetails.isNotEmpty)
                ...educationDetails.map((detail) {
                  return EducationDetailsTimeLine(
                    education: detail,
                    isDarkMode: isDarkMode,
                  );
                })
              else
                Text(
                  "No education details added yet.",
                  style: TextStyle(
                    fontSize: 17,
                    color: isDarkMode ? Colors.white : Colors.black54,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class EducationDetailsTimeLine extends StatelessWidget {
  final Map<String, dynamic> education;
  final bool isDarkMode;

  const EducationDetailsTimeLine({
    super.key,
    required this.education,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    void _handleEducationDelete() async {
      bool isConfirmed = await showCustomConfirmationDialog(context,
          "Are you sure you want to delete this education details ? This action cannot be undone !");
      if (isConfirmed) {
        Provider.of<ProfileSetupProvider>(context, listen: false)
            .deleteEducationDetails(context, education['id']);
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${formatEduDate(education['start_date']) ?? ''} - ${education['is_currently_studying'] ? 'Now' : formatEduDate(education['end_date'])}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
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
                        height: 80,
                        color: Colors.blue.shade400,
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          education['degree_type'],
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
                          education['education_program'],
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
                          education['institute_name'],
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode
                                ? Colors.grey.shade500
                                : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _handleEducationDelete();
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
