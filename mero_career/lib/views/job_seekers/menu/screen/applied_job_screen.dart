import 'package:flutter/material.dart';
import 'package:mero_career/main.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/job_seekers/menu/widgets/applied_post_details.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';

class AppliedJobScreen extends StatefulWidget {
  const AppliedJobScreen({super.key});

  @override
  State<AppliedJobScreen> createState() => _AppliedJobScreenState();
}

class _AppliedJobScreenState extends State<AppliedJobScreen> {
  late Future<List<dynamic>>? _appliedJobs;
  String _listJobsBy = "Under Review";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAppliedJobs();
    });
  }

  void _getAppliedJobs() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .getAppliedJobs(_listJobsBy);
    if (mounted) {
      setState(() {});
    }
  }

  final List<String> _filterList = [
    'Under Review',
    'Reviewed',
    'Shortlisted',
    'Interview Scheduled',
    'Accepted',
    'Rejected'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Applied Job",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 24),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  _listJobsBy,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MyDivider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filterList.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: FilterChip(
                      label: Text(
                        filter.toUpperCase(),
                        style: const TextStyle(fontSize: 12.5),
                      ),
                      selected: _listJobsBy == filter,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _listJobsBy = filter;
                          });
                          _getAppliedJobs();
                        }
                      },
                      selectedColor:
                          filter != "Rejected" ? Colors.blue : Colors.red,
                      padding: const EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            MyDivider(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Consumer<JobSeekerJobProvider>(
                        builder: (context, provider, child) {
                          final appliedPosts = provider.appliedJobs;
                          if (appliedPosts == null || appliedPosts.isEmpty) {
                            return const Center(
                              child: Text(
                                "No applied jobs found!",
                                style: TextStyle(
                                    fontSize: 18.5, letterSpacing: 0.2),
                              ),
                            );
                          }
                          return Column(
                            children: appliedPosts.map((job) {
                              return AppliedPostDetails(
                                size: MediaQuery.of(context).size,
                                appliedJob: job,
                                filterStatusBy: _listJobsBy,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
