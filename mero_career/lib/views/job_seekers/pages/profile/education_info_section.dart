import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/widgets/profile/education_higher_level.dart';
import 'package:mero_career/views/job_seekers/widgets/profile/education_school_level.dart';

class EducationInfoSection extends StatelessWidget {
  const EducationInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Education",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4),
              ),
              SizedBox(
                height: 12,
              ),
              TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.cast_for_education),
                    text: "Schooling",
                  ),
                  Tab(
                    icon: Icon(Icons.school),
                    text: "Higher Education",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: const [
                    EducationSchoolLevel(),
                    EducationHigherLevel(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
