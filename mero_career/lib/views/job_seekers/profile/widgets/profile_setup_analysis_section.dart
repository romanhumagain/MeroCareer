import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/job_seekers/profile/screen/education_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/experience_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/project_details_screen.dart';
import 'package:mero_career/views/job_seekers/profile/screen/skill_details_page.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_heading_section.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_recommendation_card.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_summary_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../screen/career_preference_screen.dart';

class ProfileSetupAnalysisSection extends StatelessWidget {
  const ProfileSetupAnalysisSection({
    super.key,
    required this.size,
  });

  final Size size;

  Color _getAnalysisColor(int percentage) {
    if (percentage < 50) {
      return Colors.red;
    } else if (percentage >= 50 && percentage < 91) {
      return Colors.orange;
    } else if (percentage > 91 && percentage <= 100) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

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
          child: Consumer<ProfileSetupProvider>(
              builder: (context, provider, child) {
            final analysisData = provider.profileAnalysisData;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                      height: size.height,
                      width: size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircularPercentIndicator(
                            radius: 28.0,
                            lineWidth: 5.0,
                            animation: true,
                            percent: analysisData?['percentage'] / 100,
                            center: Text(
                              "${analysisData?['percentage']}.0%",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor:
                                _getAnalysisColor(analysisData?['percentage']),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "MeroCareer experts suggest you to have a complete profile",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${analysisData?['missing_details']} Missing details !",
                            style: TextStyle(
                                color: analysisData!['missing_details'] > 0
                                    ? Colors.red
                                    : Colors.green),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "20",
                  icon: Icons.file_copy,
                  heading: "Never miss adding your resume ",
                  buttonTitle: analysisData['has_resume_uploaded']
                      ? "View Resume"
                      : "Upload Resume",
                  onTap: () {
                    _showResumeUploadModalScreen(context);
                  },
                  hasData: analysisData?['has_resume_uploaded'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.camera_alt,
                  heading: "Upload your profile picture ",
                  buttonTitle: analysisData['has_profile_image']
                      ? "View Image"
                      : "Upload Photo",
                  onTap: () {
                    ProfileHeadingSection headingSection =
                        ProfileHeadingSection();
                    headingSection.showHeadingTopScreen(context);
                  },
                  hasData: analysisData?['has_profile_image'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.person,
                  heading: "Add your profile summary ",
                  buttonTitle: analysisData['has_profile_summary']
                      ? "View Profile"
                      : "About Yourself",
                  onTap: () {
                    ProfileSummary profileSummary = ProfileSummary(size: size);
                    profileSummary.showAddProfileSummarySection(context);
                  },
                  hasData: analysisData?['has_profile_summary'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.school,
                  heading: "Add your education details ",
                  buttonTitle: analysisData?['has_education_details']
                      ? "View Details"
                      : "Add Education",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EducationDetailsScreen()));
                  },
                  hasData: analysisData?['has_education_details'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.work,
                  heading: "Add your experience details ",
                  buttonTitle: analysisData?['has_experience_details']
                      ? "View Details"
                      : "Add Details",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExperienceDetailsScreen()));
                  },
                  hasData: analysisData?['has_experience_details'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.folder,
                  heading: "Add your project details ",
                  buttonTitle: analysisData?['has_project_details']
                      ? "View Project"
                      : "Add Project",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectDetailsScreen()));
                  },
                  hasData: analysisData?['has_project_details'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.auto_awesome,
                  heading: "Add your skills details ",
                  buttonTitle: analysisData?['has_skills']
                      ? "View Skills"
                      : "Add Skills",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SkillDetailsPage()));
                  },
                  hasData: analysisData?['has_skills'],
                ),
                SizedBox(
                  width: 15,
                ),
                ProfileRecommendationCard(
                  size: size,
                  percentageCover: "10",
                  icon: Icons.work_outline,
                  heading: "Add career preference ",
                  buttonTitle: analysisData?['has_career_preference']
                      ? "View Preference"
                      : "Add Preference",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CareerPreferenceScreen()));
                  },
                  hasData: analysisData?['has_career_preference'],
                ),
              ],
            );
          })),
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
