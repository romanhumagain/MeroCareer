import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final headingTextStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage(
                              'assets/images/pp.jpg',
                            ),
                          ),
                        ),
                        Text(
                          "Roman Humagain",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 18, letterSpacing: 0.4),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mobile App Developer",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 15, letterSpacing: 0.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.mode_edit_outline,
                    size: 22,
                    color: Colors.blue,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "2",
                        style: headingTextStyle?.copyWith(
                            fontSize: 15.5, color: Colors.blue),
                      ),
                      Text(
                        "Job Applied",
                        style: headingTextStyle,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 2,
                    height: 30,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Text(
                        "0",
                        style: headingTextStyle?.copyWith(
                            fontSize: 15.5, color: Colors.blue),
                      ),
                      Text(
                        "Application Under Review",
                        style: headingTextStyle,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.eye_solid,
                    size: 19,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Preview Profile",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              SizedBox(height: 10),
              ProfileSetupAnalysisSection(size: size),
              SizedBox(height: 10),
              BasicDetailsCard(size: size),
              SizedBox(
                height: 15,
              ),
              CareerPreferenceCard(size: size),
              SizedBox(
                height: 15,
              ),
              ProfileSummary(size: size),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class CareerPreferenceCard extends StatelessWidget {
  const CareerPreferenceCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCareerPreferenceScreen(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: size.width / 1.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Career Preference",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.4),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_upward,
                              color: Colors.green.shade100),
                          Text(
                            "Boost 12 %",
                            style: TextStyle(color: Colors.green.shade100),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.shield,
                  color: Colors.yellow.shade300,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add details about your preferred job profile. This helps us personalize your job recommendation",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    PreferenceBadge(
                      size: size,
                      title: "Location",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    PreferenceBadge(
                      size: size,
                      title: "Role",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    PreferenceBadge(
                      size: size,
                      title: "Job Type",
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showCareerPreferenceScreen(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: size.height / 1.15,
            width: size.width,
            decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text("Profile Preference",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Add details about your prefered job profile. This helps us personalise your job recommendations",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class PreferenceBadge extends StatelessWidget {
  final String title;

  const PreferenceBadge({super.key, required this.size, required this.title});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade900),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 17,
          ),
        ],
      ),
    );
  }
}

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
                    center: new Text(
                      "20.0%",
                      style: new TextStyle(
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
              onTap: () {},
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.camera_alt,
              heading: "Profile with photo are more noticeable ",
              buttonTitle: "Upload Photo",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileRecommendationCard extends StatelessWidget {
  final String percentageCover;
  final IconData icon;
  final String heading;
  final String buttonTitle;
  final Function onTap;

  const ProfileRecommendationCard(
      {super.key,
      required this.size,
      required this.percentageCover,
      required this.icon,
      required this.heading,
      required this.buttonTitle,
      required this.onTap});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: size.height,
      width: size.width / 2.9,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 18,
                  ),
                  Text(
                    "$percentageCover %",
                    style: TextStyle(
                        color: Colors.green, letterSpacing: 0.1, fontSize: 12),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              icon,
              color: Colors.blue.shade700,
              size: 19,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            heading,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14, color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              padding: EdgeInsets.all(3.1),
              width: size.width / 3.5,
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  buttonTitle,
                  style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Summary",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 17.2),
              ),
              Text(
                "Add",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Highlight your key career achievements to help recruiters knows your potential",
            style: Theme.of(context).textTheme.titleSmall,
          )
        ]),
      ),
    );
  }
}

class BasicDetailsCard extends StatelessWidget {
  const BasicDetailsCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Basic Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17.3),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: const [
                Row(
                  children: const [
                    Icon(
                      Icons.card_travel,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Fresher")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("Panauti, Kavre")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.email_outlined,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("romanhumagian@gmail.com")
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.phone,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Text("9840617106")
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
