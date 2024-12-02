import 'package:flutter/material.dart';

import '../../../job_seekers/home/screen/job_details_screen.dart';
import '../../applicants/screen/applicants_detail_screen.dart';

class PostedJobDetailsScreen extends StatelessWidget {
  const PostedJobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          toolbarHeight: 70,
          title: const Text(
            "Flutter Developer ",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.5,
                letterSpacing: 0.4),
          ),
        ),
        body: Stack(children: [
          Column(
            children: [
              SizedBox(height: 10),

              // Job title and save button
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Flutter Developer",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 20.5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text("Deadline: "),
                        Text(
                          "5 days from now ",
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // TabBar and TabBarView
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
                  child: Column(
                    children: [
                      const TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: [
                          Tab(
                            icon: Icon(Icons.info_outline),
                            text: "Job Info",
                          ),
                          Tab(
                            icon: Icon(Icons.list_alt),
                            text: "Requirements",
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14),
                          child: TabBarView(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  BasicJobInfo(size: size),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RequirementSkills(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceContainer,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  JobSpecification(
                                    size: size,
                                  )
                                ],
                              ),
                              RequirementSkills(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height / 13.5,
              width: size.width,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.surface),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ApplicantsDetailScreen(
                                      jobName: "Flutter Developer",
                                    )));
                      },
                      child: Container(
                        width: size.width / 1.4,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            "View Applicants",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class RequirementSkills extends StatelessWidget {
  const RequirementSkills({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Professional Skill Required",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 17.5),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
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
        ],
      ),
    );
  }
}

class JobSpecification extends StatelessWidget {
  const JobSpecification({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Specification",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(
            size: size, data: "Education Required", value: "Under Graduate"),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(size: size, data: "Experience", value: "2 year"),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(size: size, data: "Salary", value: "20k - 30k "),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class BasicJobInfo extends StatelessWidget {
  const BasicJobInfo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Job Information",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 15,
        ),
        JobInfoTable(
          size: size,
          data: "No. of Vacancy",
          value: "2",
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Available for ",
          value: "Part Time",
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Category",
          value: "IT & Telecommunication",
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Job Level",
          value: "Senior Level",
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class JobInfoTable extends StatelessWidget {
  final Size size;
  final String data;
  final String value;

  const JobInfoTable(
      {super.key, required this.size, required this.data, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size.width / 3,
          child: Text(
            data,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Container(
          width: size.width / 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.4),
          ),
        )
      ],
    );
  }
}
