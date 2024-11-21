import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/widgets/continue_skip.dart';
import 'package:mero_career/views/job_seekers/widgets/profile/project_details_form.dart';

class ProjectsDetailsSection extends StatefulWidget {
  const ProjectsDetailsSection({super.key});

  @override
  State<ProjectsDetailsSection> createState() => _ProjectsDetailsSectionState();
}

class _ProjectsDetailsSectionState extends State<ProjectsDetailsSection> {
  bool? hasProject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Do you have any project done so far?",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ToggleButtons(
                      isSelected: [hasProject == true, hasProject == false],
                      onPressed: (index) {
                        setState(() {
                          hasProject = index == 0;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Colors.white,
                      fillColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(fontSize: 16),
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Yes"),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ],
                ),
                if (hasProject != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: hasProject!
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ProjectDetailsForm(),
                              ],
                            ),
                          )
                        : Text(
                            "Okey, you can add it later after completing projects !",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          ),
                  ),
              ],
            ),
            SizedBox(height: 40),
            ContinueSkip(onContinue: () {})
          ],
        ),
      ),
    );
  }
}
