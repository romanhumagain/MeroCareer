import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_provider.dart';
import 'package:mero_career/views/recruiters/home/screen/job_listing_screen.dart';
import 'package:mero_career/views/recruiters/home/widgets/home_screen_heading.dart';
import 'package:provider/provider.dart';

import '../widgets/applicants_details.dart';
import '../widgets/posted_job_details_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HomeScreenHeading(size: size),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  width: size.width,
                  height: size.height / 7,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KeyMatricesCard(
                          size: size,
                          heading: "Active Job Posting",
                          count: "5",
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        KeyMatricesCard(
                          size: size,
                          heading: "Application Received",
                          count: "2",
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        KeyMatricesCard(
                          size: size,
                          heading: "Jobs Under Review",
                          count: "2",
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        KeyMatricesCard(
                          size: size,
                          heading: "Total Job Posted",
                          count: "12",
                        ),
                        // KeyMatricesCard(size: size),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 6,
                ),
                RecentJobsPosting(
                    size: size,
                    cardColor: cardColor,
                    tertiaryColor: tertiaryColor),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent applications for jobs ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.2,
                                letterSpacing: 0.4),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "View All",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ApplicantsDetails(size: size),
                          SizedBox(
                            width: 10,
                          ),
                          ApplicantsDetails(size: size),
                        ],
                      ),
                    ),
                  ],
                ),
                ClosingMessage()
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ClosingMessage extends StatelessWidget {
  const ClosingMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Find the perfect fit for your team with ease!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Colors.blue.shade900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your next great hire is just a click away!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Add navigation or action here
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Start Hiring Now",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class RecentJobsPosting extends StatefulWidget {
  const RecentJobsPosting({
    super.key,
    required this.size,
    required this.cardColor,
    required this.tertiaryColor,
  });

  final Size size;
  final Color cardColor;
  final Color tertiaryColor;

  @override
  State<RecentJobsPosting> createState() => _RecentJobsPostingState();
}

class _RecentJobsPostingState extends State<RecentJobsPosting> {
  @override
  void initState() {
    super.initState();
    Provider.of<JobProvider>(context, listen: false).getJobPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Jobs Posting",
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
                          builder: (context) => JobListingsScreen()));
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
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer<JobProvider>(
                builder: (context, jobProvider, child) {
                  final jobPosts = jobProvider.postedJobLists;
                  if (jobProvider.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (jobPosts == null || jobPosts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No Job Posts Found!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Start by creating your first job post\nto attract potential candidates.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Row(
                    children: jobPosts.take(5).map((job) {
                      return PostedJobDetailsCard(
                        size: widget.size,
                        cardColor: widget.cardColor,
                        tertiaryColor: widget.tertiaryColor,
                        job: job,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class KeyMatricesCard extends StatelessWidget {
  final String heading;
  final String count;

  const KeyMatricesCard({
    super.key,
    required this.size,
    required this.heading,
    required this.count,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(8),
        width: size.width / 3.7,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              count,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 20.8,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
            )
          ],
        ),
      ),
    );
  }
}
