import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/map/screen/company_map.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
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
              // Job image at the top
              SizedBox(
                width: size.width,
                height: size.height / 6.9,
                child: Image.asset(
                  'assets/images/job_details/hiring.webp',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Company info
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey,
                    child: Image.asset(
                      'assets/images/company_logo/leapfrog.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "F1soft International pvt.ltd",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Software Companies",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

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
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.bookmark_border,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Text("Apply Before: "),
                        Text(
                          "5 days from now !",
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
                          Tab(
                            icon: Icon(Icons.business),
                            text: "Company Profile",
                          ),
                          Tab(
                            icon: Icon(Icons.monetization_on),
                            text: "Salary",
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
                                    height: 15,
                                  ),
                                  RequirementSkills(),
                                ],
                              ),
                              RequirementSkills(),
                              const Text("Company Profile"),
                              Wrap(
                                spacing: 15,
                                // Horizontal spacing between children
                                runSpacing: 8,
                                // Vertical spacing between rows
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.school, color: tertiaryColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Under Graduate (Bachelor)",
                                        style: TextStyle(color: tertiaryColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.card_giftcard,
                                          color: tertiaryColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Mid Level",
                                        style: TextStyle(color: tertiaryColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.roller_shades_closed_outlined,
                                          color: tertiaryColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Not Disclosed",
                                        style: TextStyle(color: tertiaryColor),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.location_on,
                                          color: tertiaryColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Pulchowk, Lalitpur",
                                        style: TextStyle(color: tertiaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                          "Apply Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyMap()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                    ),
                  )
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
            alignment: WrapAlignment.start, // Aligns children to the start
            spacing: 10, // Horizontal spacing between skill cards
            runSpacing: 10, // Vertical spacing between rows of skill cards
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
              ?.copyWith(fontSize: 17.5),
        ),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(
            size: size, data: "Education Required", value: "Under Graduate"),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(size: size, data: "Experience", value: "More than 2 year"),
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
              ?.copyWith(fontSize: 17.5),
        ),
        SizedBox(
          height: 15,
        ),
        JobInfoTable(
          size: size,
          data: "No. of Vacency",
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
          height: 10,
        ),
      ],
    );
  }
}

class SkillCard extends StatelessWidget {
  final String skill;

  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Text(
        skill,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w500),
      ),
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
                .titleSmall
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
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
