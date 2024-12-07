import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../widgets/custom_confirmation_message.dart';

class ProjectDetailsData extends StatelessWidget {
  const ProjectDetailsData({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Consumer<ProfileSetupProvider>(builder: (context, provider, child) {
      final List? projectDetails = provider.projectDetails;
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
            else if (projectDetails != null && projectDetails.isNotEmpty)
              ...projectDetails.map((detail) {
                return ProjcetDetailsTimeline(
                  project: detail,
                );
              })
            else
              Text(
                "No project details added yet.",
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

class ProjcetDetailsTimeline extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjcetDetailsTimeline({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    void _handleProjectDelete() async {
      bool isConfirmed = await showCustomConfirmationDialog(context,
          "Are you sure you want to delete this project details ? This action cannot be undone !");
      if (isConfirmed) {
        Provider.of<ProfileSetupProvider>(context, listen: false)
            .deleteProjectDetails(context, project['id']);
      }
    }

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project['project_title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color:
                      isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
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
                          color: Colors.red.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 70,
                        color: Colors.red.shade300,
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: 210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['role'],
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? Colors.grey.shade300
                                : Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 4),
                        SizedBox(height: 4),
                        SizedBox(
                          width: size.width / 1.99,
                          child: Text(
                            project['project_description'],
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
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
                  _handleProjectDelete();
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
