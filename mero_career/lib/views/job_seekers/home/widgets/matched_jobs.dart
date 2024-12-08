import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:provider/provider.dart';

import '../screen/all_recent_jobs_screen.dart';
import 'job_details_card.dart';

class MatchedJobs extends StatefulWidget {
  const MatchedJobs({
    super.key,
    required this.size,
    required this.cardColor,
    required this.tertiaryColor,
  });

  final Size size;
  final Color cardColor;
  final Color tertiaryColor;

  @override
  State<MatchedJobs> createState() => _MatchedJobsState();
}

class _MatchedJobsState extends State<MatchedJobs> {
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jobs that matched you",
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
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer<JobSeekerJobProvider>(
                  builder: (context, provider, child) {
                final matchedJobLists = provider.matchedJobs;
                if (provider.matchedJobs == null ||
                    provider.matchedJobs!.isEmpty) {
                  return Center(child: Text("No matched jobs available"));
                }
                return Row(
                  children: matchedJobLists!.take(5).map((job) {
                    return JobDetailsCard(
                      size: widget.size,
                      cardColor: widget.cardColor,
                      tertiaryColor: widget.tertiaryColor,
                      job: job,
                    );
                  }).toList(),
                );
              })),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
