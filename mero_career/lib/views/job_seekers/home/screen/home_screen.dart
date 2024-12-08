import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/job_seekers/home/screen/all_jobs.dart';
import 'package:mero_career/views/job_seekers/home/screen/all_recent_jobs_screen.dart';
import 'package:mero_career/views/job_seekers/home/screen/hot_jobs.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_organization/view_jobs_by_company.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_expiring_screen.dart';
import 'package:mero_career/views/job_seekers/home/screen/top_jobs.dart';
import 'package:provider/provider.dart';

import '../widgets/expiring_jobs.dart';
import '../widgets/home_screen_heading.dart';
import '../widgets/job_category_section.dart';
import '../widgets/job_details_card.dart';
import '../widgets/matched_jobs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              height: 14,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 2),
            // recent jobs for you

            MatchedJobs(
                size: size, cardColor: cardColor, tertiaryColor: tertiaryColor),

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllJobs()));
              },
              child: Container(
                width: size.width / 1.2,
                padding: EdgeInsets.all(9.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade300, Colors.blue.shade600]),
                  border: Border.all(
                    color: isDarkMode
                        ? Colors.grey.shade900
                        : Colors.grey.shade300, // Set the border color to blue
                    width: 2.0, // Optional: Set the border width
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "View All Jobs ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.all_inbox,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),

            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 15),
            ExpiringJobs(size: size),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(
              height: 10,
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
                    child: Text(
                      "Explore Companies",
                      style: TextStyle(
                          color:
                              isDarkMode ? Colors.white : Colors.grey.shade700,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
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
