import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_details.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/education_details.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_divider.dart';

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

  const JobSeekerProfilePreview({super.key, required this.jobSeekerId});

  @override
  State<JobSeekerProfilePreview> createState() =>
      _JobSeekerProfilePreviewState();
}

class _JobSeekerProfilePreviewState extends State<JobSeekerProfilePreview> {
  late Future<Map<String, dynamic>?>? _profileDetails;
  String role = "";

  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();
    fetchUserRole();
    _profileDetails = _fetchProfileDetails();
  }

  void fetchUserRole() async {
    role = (await authServices.getUserRole())!;
  }

  JobSeekerServices jobSeekerServices = JobSeekerServices();

  Future<Map<String, dynamic>?> _fetchProfileDetails() async {
    try {
      final response = await jobSeekerServices
          .fetchJobSeekerProfilePreview(widget.jobSeekerId);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
          context: context,
          message: "Couldn't Preview Profile",
          type: MessageType.error,
        );
      } else if (response.statusCode == 401) {
        AuthServices authServices = AuthServices();
        await authServices.logoutUser();
        showCustomFlushbar(
          context: context,
          message: "Session expired! Please login again",
          type: MessageType.error,
        );
        await Future.delayed(Duration(seconds: 2));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      print("Error while previewing user: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _profileDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No profile data available"));
          }
          final profileData = snapshot.data!;
          print(profileData['prefered_job_category']);
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfilePreviewHeading(profileData: profileData, role: role),
                    MyDivider(),
                    SizedBox(height: 12),
                    ReviewResume(
                        size: MediaQuery.of(context).size, data: profileData),
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
                                builder: (context) => ChatDetails()),
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
        },
      ),
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
