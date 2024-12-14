import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_details.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/screen/chat_with_jobseeker.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/education_details.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/preview_heading_for_job_seeker.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../providers/job_provider.dart';
import '../../../../services/auth_services.dart';
import '../../../shared/login/login_page.dart';
import '../../home/widgets/skill_card.dart';
import '../widgets/about_me.dart';
import '../widgets/job_preference.dart';
import '../widgets/profile_preview_heading.dart';
import '../widgets/project_details.dart';
import '../widgets/review_resume.dart';
import '../widgets/work_experience.dart';

class JobSeekerProfilePreview extends StatefulWidget {
  final int jobSeekerId;
  final int applicantId;

  const JobSeekerProfilePreview(
      {super.key, required this.jobSeekerId, this.applicantId = 0});

  @override
  State<JobSeekerProfilePreview> createState() =>
      _JobSeekerProfilePreviewState();
}

class _JobSeekerProfilePreviewState extends State<JobSeekerProfilePreview> {
  String role = "";
  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();

    fetchUserRole();
    fetchJobSeekerProfile();

    if (widget.applicantId != 0) {
      fetchJobApplicantsDetails();
    }
  }

  void fetchUserRole() async {
    role = (await authServices.getUserRole())!;
  }

  JobSeekerServices jobSeekerServices = JobSeekerServices();

  void fetchJobSeekerProfile() async {
    await Provider.of<JobProvider>(context, listen: false)
        .getJobSeekerDetails(widget.jobSeekerId);

    await Provider.of<ProfileSetupProvider>(context, listen: false)
        .fetchProfileCompletionDetails(widget.jobSeekerId);
  }

  void fetchJobApplicantsDetails() async {
    await Provider.of<JobProvider>(context, listen: false)
        .getApplicantDetails(widget.applicantId);
  }

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
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer<JobProvider>(builder: (context, provider, child) {
        final Map<String, dynamic>? jobSeekerDetails =
            provider.jobSeekerProfileDetails;
        bool isLoading = provider.isLoading;
        // if (isLoading) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        if (jobSeekerDetails!.isEmpty) {
          return Text(
            "No Job Seeker Details Found !",
            style: TextStyle(fontSize: 14),
          );
        }
        final profileData = jobSeekerDetails;
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.applicantId != 0
                      ? ProfilePreviewHeading(
                          profileData: profileData,
                          role: role,
                          applicantId: widget.applicantId)
                      : PreviewHeadingForJobSeeker(
                          profileData: profileData, role: role),
                  MyDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: Consumer<ProfileSetupProvider>(
                        builder: (context, provider, child) {
                      final analysisData = provider.profileCompletionData;
                      if (analysisData!.isEmpty) {
                        return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue,
                          size: 28,
                        );
                      }
                      return Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 25.0,
                            lineWidth: 4.0,
                            animation: true,
                            percent: analysisData['percentage'] / 100,
                            center: Text(
                              "${analysisData['percentage']}.0%",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 10.0),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor:
                                _getAnalysisColor(analysisData['percentage']),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          analysisData['missing_details'] == 0
                              ? Text(
                                  "All details provided !",
                                  style: TextStyle(color: Colors.green),
                                )
                              : Text(
                                  "${analysisData['missing_details']} Missing Details !",
                                  style: TextStyle(color: Colors.red),
                                )
                        ],
                      );
                    }),
                  ),
                  MyDivider(),
                  SizedBox(height: 12),
                  ReviewResume(
                      size: MediaQuery.of(context).size,
                      data: profileData['resume_details']),
                  SizedBox(height: 2),
                  JobPreference(
                      size: MediaQuery.of(context).size,
                      data: profileData['prefered_job_category']),
                  MyDivider(),
                  AboutMeSection(
                      size: MediaQuery.of(context).size, data: profileData),
                  MyDivider(),
                  EducationDetails(
                      data: profileData['job_seeker_education_details']),
                  MyDivider(),
                  ProfessionalSkills(
                      skills: profileData['job_seeker_skill_details']),
                  MyDivider(),
                  WorkExperience(
                      data: profileData['job_seeker_experience_details']),
                  MyDivider(),
                  ProjectDetails(
                      data: profileData['job_seeker_project_details']),
                ],
              ),
            ),
            role == "recruiter"
                ? Positioned(
                    bottom: 30,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatWithJobseeker(
                                    jobSeekerId: jobSeekerDetails['id'],
                                    name: jobSeekerDetails['full_name'],
                                    imageUrl: jobSeekerDetails['profile_image'],
                                  )),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          CupertinoIcons.chat_bubble_fill,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        );
      }),
    );
  }
}

class ProfessionalSkills extends StatelessWidget {
  final List<dynamic> skills;

  const ProfessionalSkills({
    super.key,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Professional Skills",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 18.5, letterSpacing: 0.2),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 28,
              )
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: skills
                  .map<Widget>((skill) => SkillCard(skill: skill['name']))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
