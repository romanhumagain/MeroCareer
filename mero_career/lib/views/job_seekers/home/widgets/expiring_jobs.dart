import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../screen/jobs_expiring_screen.dart';
import 'job_details_card.dart';

class ExpiringJobs extends StatefulWidget {
  const ExpiringJobs({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ExpiringJobs> createState() => _ExpiringJobsState();
}

class _ExpiringJobsState extends State<ExpiringJobs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchExpiringJob();
  }

  void _fetchExpiringJob() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .fetchExipringJobs();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return SizedBox(
      width: widget.size.width,
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
                            builder: (context) => JobsExpiringScreen()));
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
              child: Consumer<JobSeekerJobProvider>(
                  builder: (context, provider, child) {
                final expiringJobs = provider.expiringJobs;
                final isLoading = provider.isLoading;
                if (expiringJobs!.isEmpty) {
                  return Center(
                    child: Text("No expiring jobs found currently! "),
                  );
                }
                return Row(
                  children: expiringJobs.take(5).map((job) {
                    return JobDetailsCard(
                      size: widget.size,
                      cardColor: cardColor,
                      tertiaryColor: tertiaryColor,
                      job: job,
                    );
                  }).toList(),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
