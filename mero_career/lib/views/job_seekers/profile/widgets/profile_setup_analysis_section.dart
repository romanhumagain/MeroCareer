import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/job_seekers/profile/screen/education_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/experience_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/project_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/skill_details_page.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_heading_section.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_recommendation_card.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_summary_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'career_preference_card.dart';

class ProfileSetupAnalysisSection extends StatelessWidget {
  const ProfileSetupAnalysisSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      height: size.height / 4,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height,
              width: size.width / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircularPercentIndicator(
                    radius: 26.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: 0.7,
                    center: Text(
                      "20.0%",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.red,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "MeroCareer experts suggest you to have a complete profile",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "10 Missing details !",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.file_copy,
              heading: "Never miss adding your resume ",
              buttonTitle: "Upload Resume",
              onTap: () {
                _showResumeUploadModalScreen(context);
              },
              hasData: false,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.camera_alt,
              heading: "Upload your profile picture ",
              buttonTitle: "Upload Photo",
              onTap: () {
                ProfileHeadingSection headingSection = ProfileHeadingSection();
                headingSection.showHeadingTopScreen(context);
              },
              hasData: true,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.person,
              heading: "Add your profile summary ",
              buttonTitle: "Personal Details",
              onTap: () {
                ProfileSummary profileSummary = ProfileSummary(size: size);
                profileSummary.showAddProfileSummarySection(context);
              },
              hasData: true,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.school,
              heading: "Add your education details ",
              buttonTitle: "Education details",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EducationDetailsScreen()));
              },
              hasData: true,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "0",
              icon: Icons.work,
              heading: "Add your experience details ",
              buttonTitle: "Project Details",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExperienceDetailsScreen()));
              },
              hasData: false,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "0",
              icon: Icons.folder,
              heading: "Add your project details ",
              buttonTitle: "Project Details",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen()));
              },
              hasData: false,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.auto_awesome,
              heading: "Add your skills details ",
              buttonTitle: "Skills details",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SkillDetailsPage()));
              },
              hasData: true,
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "15",
              icon: Icons.work_outline,
              heading: "Add career preference ",
              buttonTitle: "Add Preference",
              onTap: () {
                CareerPreferenceCard career = CareerPreferenceCard(
                  size: MediaQuery.of(context).size,
                );
                career.showCareerPreferenceScreen(context);
              },
              hasData: true,
            ),
          ],
        ),
      ),
    );
  }

  void _showResumeUploadModalScreen(BuildContext context) async {
    final size = MediaQuery.of(context).size;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

        void pickResume() async {
          // Using FilePicker to select the resume
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc', 'docx'],
          );

          if (result != null) {
            String? filePath = result.files.single.path;
            if (filePath != null) {
              // Handle the selected file (e.g., upload or save)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Resume uploaded successfully!"),
              ));
            }
          } else {
            // User canceled the picker
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Resume upload canceled."),
            ));
          }
        }

        return Container(
          height: size.height / 1.15,
          width: size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ModalTopBar(),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Text(
                          "Upload Resume",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 21),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Message
                      Text(
                        "Please upload your most recent resume. Accepted file types: PDF, DOC, DOCX.",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 15,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey,
                            ),
                      ),
                      SizedBox(height: 20),
                      // Upload Button
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: pickResume,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: Icon(
                            Icons.upload_file,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Upload Resume",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Additional Message
                      Text(
                        "Your uploaded resume will be securely stored and used only for job applications.",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontSize: 14,
                              color: isDarkMode
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade500,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
