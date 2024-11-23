import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          title: Text(
            "Flutter Developer ",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.5,
                letterSpacing: 0.4),
          ),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                width: size.width,
                height: size.height / 6.5,
                child: Image.asset(
                  'assets/images/job_details/hiring.webp',
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: Colors.grey,
                    child: Image.asset(
                      'assets/images/company_logo/leapfrog.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
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
            ),
            SizedBox(
              height: 10,
            ),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.bookmark_border,
                          size: 28,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Text("Apply Before: "),
                      Text(
                        "5 days from now !",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    spacing: 15, // Horizontal spacing between children
                    runSpacing: 8, // Vertical spacing between rows
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.school,
                            color: tertiaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Under Graduate (Bachelor)",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            color: tertiaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Mid Level",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.roller_shades_closed_outlined,
                            color: tertiaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Not Disclosed",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: tertiaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Pulchowk, Lalitpur",
                            style: TextStyle(color: tertiaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 25,
                  ),
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
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                      size: size,
                      data: "Education Required",
                      value: "Under Graduate"),
                  SizedBox(
                    height: 2,
                  ),
                  JobInfoTable(
                      size: size,
                      data: "Experience",
                      value: "More than 2 year"),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Professional Skill Required ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17.5),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      SkillCard(skill: "Dart"),
                      SizedBox(
                        width: 8,
                      ),
                      SkillCard(skill: "Flutter"),
                      SizedBox(
                        width: 8,
                      ),
                      SkillCard(skill: "RESTful API"),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
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
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Text(
        skill,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
