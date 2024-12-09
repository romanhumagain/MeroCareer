import 'package:flutter/material.dart';
import 'package:mero_career/main.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/job_seekers/menu/widgets/applied_post_details.dart';
import 'package:mero_career/views/recruiters/home/widgets/applicants_details.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';
import '../../../../providers/job_seeker_job_provider.dart';

class SelectedJobApplicants extends StatefulWidget {
  final int jobId;
  final String jobTitle;

  const SelectedJobApplicants(
      {super.key, required this.jobId, required this.jobTitle});

  @override
  State<SelectedJobApplicants> createState() => _SelectedJobApplicantsState();
}

class _SelectedJobApplicantsState extends State<SelectedJobApplicants> {
  late Future<List<dynamic>>? _selectedJobApplicants;
  String _listJobsBy = "Under Review";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSelectJobApplication();
    });
  }

  Future<void> getSelectJobApplication() async {
    await Provider.of<JobProvider>(context, listen: false)
        .fetchSelectedJobApplicants(widget.jobId, _listJobsBy);
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: size.height / 10,
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
                child: Row(
                  children: [
                    Text(
                      widget.jobTitle,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 20.5,
                              letterSpacing: 0.4,
                              color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      _listJobsBy,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MyDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
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
                              getSelectJobApplication();
                            });
                            // apply here
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
                      child: Consumer<JobProvider>(
                        builder: (context, provider, child) {
                          final selectedJobApplicants =
                              provider.selectedJobApplicants;
                          if (selectedJobApplicants!.isEmpty) {
                            return const Center(
                              child: Text(
                                "No Applicants Found for this job !",
                                style: TextStyle(
                                    fontSize: 18.5, letterSpacing: 0.2),
                              ),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: selectedJobApplicants.map((data) {
                              return ApplicantsDetails(
                                  size: MediaQuery.of(context).size,
                                  data: data);
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
