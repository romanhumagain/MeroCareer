import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../common/app_bar.dart';
import '../widgets/job_details_card.dart';

class AllRecentJobsScreen extends StatelessWidget {
  const AllRecentJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introductory Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Column(
                children: [
                  Text(
                    "Looking for your next opportunity?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Browse through the most recent job listings tailored just for you.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                  ),
                  Image.asset(
                    'assets/images/job_details/jobs_illustration.png',
                    height: 230,
                  )
                ],
              ),
            ),

            SizedBox(height: 30),
            Column(
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: 30,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
