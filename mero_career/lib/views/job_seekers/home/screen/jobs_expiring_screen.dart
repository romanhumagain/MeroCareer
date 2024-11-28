import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../widgets/job_details_card.dart';

class JobsExpiringScreen extends StatelessWidget {
  const JobsExpiringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text("Jobs Expiring Soon"),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                  child: Column(
                    children: [
                      // Header Text
                      Text(
                        "Act Fast! These Jobs are Closing Soon",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),

                      // Subheading Description
                      Text(
                        "Explore these job opportunities before the deadline passes. Don’t miss out on your chance to apply!",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),

                      // Illustrative Icon or Graphic
                      Icon(
                        Icons.hourglass_bottom,
                        size: 80,
                        color: Colors.red[400],
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
            Column(children: [
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
          ],
        ),
      ),
    );
  }
}
