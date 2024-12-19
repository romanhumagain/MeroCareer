import 'package:flutter/material.dart';
import 'package:mero_career/views/recruiters/applicants/screen/selected_job_applicants.dart';
import 'package:mero_career/views/recruiters/applicants/widgets/job_wise_applicants.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';
import '../../home/widgets/applicants_details.dart';
import 'applicants_detail_screen.dart';

class ViewApplicantsScreen extends StatefulWidget {
  const ViewApplicantsScreen({super.key});

  @override
  State<ViewApplicantsScreen> createState() => _ViewApplicantsScreenState();
}

class _ViewApplicantsScreenState extends State<ViewApplicantsScreen> {
  String _listJobsBy = "active";
  final List<String> _filterList = ['active', 'closed'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getActiveJobWithApplication();
    });
  }

  Future<void> getActiveJobWithApplication() async {
    await Provider.of<JobProvider>(context, listen: false)
        .getActiveJobWithApplicants(_listJobsBy);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Container(
              width: size.width,
              height: size.height / 8.5,
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
                      "Discover Your Ideal Candidate",
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
                      "Analyze, shortlist, and connect with top talent.",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 14, color: Colors.grey.shade200),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filterList.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChip(
                      label: Text(
                        filter.toUpperCase(),
                        style: TextStyle(fontSize: 12.5),
                      ),
                      selected: _listJobsBy == filter,
                      onSelected: (selected) {
                        setState(() {
                          _listJobsBy = selected ? filter : 'all';
                          getActiveJobWithApplication();
                        });
                      },
                      selectedColor: Colors.blueAccent,
                      padding: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<JobProvider>(builder: (context, provider, child) {
                  final jobWithApplicants = provider.activeJobWithApplicants;

                  if (jobWithApplicants!.isEmpty) {
                    return Text("No Jobs Found");
                  }
                  return Column(
                    children: jobWithApplicants.map((job) {
                      return JobApplicants(
                        size: size,
                        job: job,
                      );
                    }).toList(),
                  );
                }),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobApplicants extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobApplicants({
    super.key,
    required this.size,
    required this.job,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      job['job_title'],
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 17, letterSpacing: 0),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 25,
                      width: 25,
                      padding: const EdgeInsets.all(3),
                      // Adjust size
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red.shade100,
                      ),
                      child: Center(
                        child: Text(
                          "${job['application'].length.toString()}",
                          style: TextStyle(color: Colors.grey.shade700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectedJobApplicants(
                                  jobTitle: job['job_title'],
                                  jobId: job['id'],
                                )));
                  },
                  child: Text(
                    "View All",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: job['application'].length > 0
                    ? job['application'].map<Widget>((data) {
                        return Row(
                          children: [
                            JobWiseApplicants(size: size, data: data),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      }).toList()
                    : [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No Applicants found for this job !",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: 14),
                          ),
                        )
                      ],
              ),
            ),
          ),
          MyDivider()
        ],
      ),
    );
  }
}
