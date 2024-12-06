import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/area_of_interest.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/education_info_section.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/personal_info_section.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/profile_picture_add_screen.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/projects_details_section.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/skils_detail_section.dart';
import 'package:mero_career/views/job_seekers/profile_setup/screen/work_experience_confirmation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProfileSetupPageview extends StatefulWidget {
  const ProfileSetupPageview({super.key});

  @override
  State<ProfileSetupPageview> createState() => _ProfileSetupPageviewState();
}

class _ProfileSetupPageviewState extends State<ProfileSetupPageview> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 60,
        title: Text(
          "Profile Setup",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontSize: 22, letterSpacing: 0.4),
        ),
      ),
      body: Column(
        children: [
          // Add padding for the smooth page indicator
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 7,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.blue,
                dotHeight: 6,
                dotWidth: 30,
              ),
            ),
          ),

          // Expanded widget to make PageView take up the rest of the space
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {});
              },
              children: const [
                PersonalInfoSection(),
                EducationInfoSection(),
                WorkExperienceConfirmation(),
                ProjectsDetailsSection(),
                AddSkillsScreen(),
                AreaOfInterest(),
                ProfilePictureAddScreen()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
