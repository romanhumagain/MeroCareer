import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../common/app_bar.dart';
import '../widgets/job_details_card.dart';

class JobsExpiringScreen extends StatelessWidget {
  const JobsExpiringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 6.5,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Act Fast! These Jobs are Closing Soon",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontSize: 21.5, color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Explore these job opportunities before the deadline passes. Don’t miss out on your chance to apply!",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 14,
                                        color: Colors.grey.shade200),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      height: 40,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
