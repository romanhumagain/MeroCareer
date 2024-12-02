import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/job_seekers/home/screen/all_jobs.dart';
import 'package:mero_career/views/job_seekers/home/screen/all_recent_jobs_screen.dart';
import 'package:mero_career/views/job_seekers/home/screen/hot_jobs.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_organization/view_jobs_by_company.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_expiring_screen.dart';
import 'package:mero_career/views/job_seekers/home/screen/top_jobs.dart';
import 'package:provider/provider.dart';

import '../widgets/home_screen_heading.dart';
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // first container
            HomeScreenHeading(size: size),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => TopJobs()));
                      },
                      child: TopJobSections(
                        cardColor: cardColor,
                        iconColor: Colors.green,
                        title: "Top Jobs",
                        subTitle: "69 vacancies",
                        icon: Icons.star,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HotJobs()));
                      },
                      child: TopJobSections(
                        cardColor: cardColor,
                        iconColor: Colors.red,
                        title: "Hot Jobs",
                        subTitle: "9 vacancies",
                        icon: Icons.local_fire_department,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AllJobs()));
                      },
                      child: TopJobSections(
                        cardColor: cardColor,
                        iconColor: Colors.blue,
                        title: "All Jobs",
                        subTitle: "9 vacancies",
                        icon: Icons.all_inbox,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 15),
            // recent jobs for you

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Column(
                children: [
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllRecentJobsScreen()));
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w500),
                        ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewJobsByCompany()));
                    },
                    child: Text("Explore Companies"),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JobsExpiringScreen()));
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.2,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SingleChildScrollView(
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
                      showSubscriptionDialog(context);
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

  void showSubscriptionDialog(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor:
              isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
          title: Text(
            "Stay Updated!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Text(
            "Subscribe now to receive timely alerts about the latest job postings, career opportunities, and updates tailored just for you. Don’t miss out on your next big break!",
            style:
                Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Not Now",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement subscription logic here
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Thank you for subscribing!"),
                  ),
                );
              },
              child: Text("Subscribe"),
            ),
          ],
        );
      },
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
