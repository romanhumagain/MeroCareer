import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/chat/screen/chat_details.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/widgets/education_details.dart';
import 'package:mero_career/views/widgets/my_divider.dart';

import '../../home/widgets/skill_card.dart';
import '../widgets/about_me.dart';
import '../widgets/job_preference.dart';
import '../widgets/profile_preview_heading.dart';
import '../widgets/project_details.dart';
import '../widgets/review_resume.dart';
import '../widgets/work_experience.dart';

class JobSeekerProfilePreview extends StatelessWidget {
  const JobSeekerProfilePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePreviewHeading(),
              MyDivider(),
              SizedBox(
                height: 12,
              ),
              ReviewResume(size: size),
              SizedBox(
                height: 2,
              ),
              JobPreference(size: size),
              MyDivider(),
              AboutMeSection(size: size),
              MyDivider(),
              EducationDetails(),
              MyDivider(),
              ProfessionalSkills(),
              MyDivider(),
              WorkExperience(),
              MyDivider(),
              ProjectDetails(),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatDetails()));
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: Icon(
                CupertinoIcons.chat_bubble_fill,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class ProfessionalSkills extends StatelessWidget {
  const ProfessionalSkills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
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
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 28,
              )
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: const [
                SkillCard(skill: "Dart"),
                SkillCard(skill: "Flutter"),
                SkillCard(skill: "RESTful API"),
                SkillCard(skill: "Django"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
