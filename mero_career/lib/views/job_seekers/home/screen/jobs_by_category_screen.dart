import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../widgets/job_details_card.dart';

class JobsByCategoryScreen extends StatelessWidget {
  final String category;

  const JobsByCategoryScreen({super.key, required this.category});

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
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 8,
              decoration: BoxDecoration(
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
                      category,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 20.5, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Latest job vacancy in $category in Nepal. Click on the job that interests you, and apply on jobs.",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 14, color: Colors.grey.shade200),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "69 Results",
                  style: TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SizedBox(height: 5),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 5),
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
            ]),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
