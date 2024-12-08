import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../common/app_bar.dart';
import '../widgets/job_details_card.dart';

class AllRecentJobsScreen extends StatefulWidget {
  const AllRecentJobsScreen({super.key});

  @override
  State<AllRecentJobsScreen> createState() => _AllRecentJobsScreenState();
}

class _AllRecentJobsScreenState extends State<AllRecentJobsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMatchedJob();
    });
  }

  void _fetchMatchedJob() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .fetchMatchedJob();
  }

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
                height: size.height / 8.4,
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
            SizedBox(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/job_details/jobs_illustration.png',
                      height: 180,
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Consumer<JobSeekerJobProvider>(
                  builder: (context, provider, child) {
                final matchedJobLists = provider.matchedJobs;
                final isLoading = provider.isLoading;
                if (matchedJobLists!.isEmpty) {
                  return Center(
                    child: Text("No recent jobs found ! "),
                  );
                }
                return Column(
                  children: matchedJobLists.map((job) {
                    return JobDetailsCard(
                      size: size,
                      cardColor: cardColor,
                      tertiaryColor: tertiaryColor,
                      job: job,
                    );
                  }).toList(),
                );
              }),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
