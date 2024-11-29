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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                width: size.width,
                height: size.height / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade500,
                      Colors.blue.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Looking for your next opportunity?",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Browse through the most recent job listings tailored just for you.",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14, color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Introductory Header
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
