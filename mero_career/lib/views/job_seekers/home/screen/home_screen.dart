import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/job_category_section.dart';
import '../widgets/job_details_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 80,
        leadingWidth: 350,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                height: 40,
              ),
              SizedBox(
                width: 3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "MeroCareer",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Your Career, Your Path",
                    style: TextStyle(color: Colors.grey, fontSize: 9.5),
                  )
                ],
              )
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: CircleAvatar(
              radius: 17,
              backgroundImage: AssetImage(
                'assets/images/pp.jpg',
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // first container
            Container(
              height: size.height / 8,
              width: size.width,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // This Column will take up the available space, pushing the icon to the far right
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.5,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          "Roman",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.5,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.4),
                        ),
                      ],
                    ),
                    // Notification Icon
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.notifications_active,
                            size: 23.5,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          isDarkMode
                              ? GestureDetector(
                                  onTap: () {
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .updateTheme(value: false);
                                  },
                                  child: Icon(
                                    Icons.dark_mode,
                                    color: Colors.white,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Provider.of<ThemeProvider>(context,
                                            listen: false)
                                        .updateTheme(value: true);
                                  },
                                  child: Icon(
                                    Icons.sunny,
                                    color: Colors.white,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            JobCategorySection(size: size, cardColor: cardColor),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    TopJobSections(
                      cardColor: cardColor,
                      iconColor: Colors.green,
                      title: "Top Jobs",
                      subTitle: "69 vacancies",
                      icon: Icons.star,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TopJobSections(
                      cardColor: cardColor,
                      iconColor: Colors.red,
                      title: "Hot Jobs",
                      subTitle: "9 vacancies",
                      icon: Icons.local_fire_department,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TopJobSections(
                      cardColor: cardColor,
                      iconColor: Colors.blue,
                      title: "All Jobs",
                      subTitle: "9 vacancies",
                      icon: Icons.all_inbox,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Divider(
              color: Colors.grey.shade600,
            ),
            SizedBox(height: 15),
            // recent jobs for you

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Column(
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Jobs for you ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.2,
                            letterSpacing: 0.4),
                      ),
                      Text(
                        "View All",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),

            // job details
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  JobDetailsCard(
                    size: size,
                    cardColor: cardColor,
                    tertiaryColor: tertiaryColor,
                    jobTitle: "AI Engineer ",
                    companyName: "F1 soft International pvt.ltd",
                    deadline: "2 hours and 51",
                    imageUrl: 'assets/images/company_logo/f1.jpg',
                  ),
                  JobDetailsCard(
                    size: size,
                    cardColor: cardColor,
                    tertiaryColor: tertiaryColor,
                    jobTitle: "Senior Software Engineer",
                    companyName: "LeapFrog Technology LTD",
                    deadline: "2 hours and 51",
                    imageUrl: 'assets/images/company_logo/leapfrog.jpg',
                  ),
                  JobDetailsCard(
                    size: size,
                    cardColor: cardColor,
                    tertiaryColor: tertiaryColor,
                    jobTitle: "Senior Backend Developer",
                    companyName: "Cotiviti Nepal",
                    deadline: "4 hours and 51",
                    imageUrl: 'assets/images/company_logo/cotiviti.jpg',
                  ),
                  JobDetailsCard(
                    size: size,
                    cardColor: cardColor,
                    tertiaryColor: tertiaryColor,
                    jobTitle: "Flutter Developer ",
                    companyName: "F1 soft International",
                    deadline: "2 hours and 51",
                    imageUrl: 'assets/images/company_logo/f1.jpg',
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Looking for Top Companies?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        letterSpacing: 0.4),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Explore job opportunities from industry-leading organizations to advance your career.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the companies page or section
                    },
                    child: Text("Explore Companies"),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            Divider(
              color: Colors.grey.shade600,
            ),
            SizedBox(height: 15),
            Container(
              width: size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jobs Expiring Soon ! ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.2,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 0.4),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.2,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        JobDetailsCard(
                          size: size,
                          cardColor: cardColor,
                          tertiaryColor: tertiaryColor,
                          jobTitle: "Senior Backend Developer",
                          companyName: "Cotiviti Nepal",
                          deadline: "4 hours and 51",
                          imageUrl: 'assets/images/company_logo/cotiviti.jpg',
                        ),
                        JobDetailsCard(
                          size: size,
                          cardColor: cardColor,
                          tertiaryColor: tertiaryColor,
                          jobTitle: "Senior Software Engineer",
                          companyName: "LeapFrog Technology LTD",
                          deadline: "2 hours and 51",
                          imageUrl: 'assets/images/company_logo/leapfrog.jpg',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Never Miss an Opportunity!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Subscribe to job alerts and get notified about the latest openings.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to subscription/sign-up page
                    },
                    child: Text("Subscribe Now"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopJobSections extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color iconColor;
  final IconData icon;

  const TopJobSections(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconColor,
      required this.cardColor,
      required this.icon});

  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                )
              ],
            )
          ]),
        ],
      ),
    );
  }
}
