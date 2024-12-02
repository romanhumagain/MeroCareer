import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Container(
              width: size.width,
              height: size.height / 7.6,
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
                JobApplicants(
                  size: size,
                  jobName: "AI Engineer",
                  applicantsCount: "5",
                ),
                SizedBox(
                  height: 3,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 5,
                ),
                JobApplicants(
                  size: size,
                  jobName: "Full Stack Developer",
                  applicantsCount: "5",
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
  final String jobName;
  final String applicantsCount;

  const JobApplicants({
    super.key,
    required this.size,
    required this.jobName,
    required this.applicantsCount,
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
                      jobName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
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
                          applicantsCount,
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
                            builder: (context) => ApplicantsDetailScreen(
                                  jobName: "Job Name",
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
                children: [
                  ApplicantsDetails(size: size),
                  SizedBox(
                    width: 10,
                  ),
                  ApplicantsDetails(size: size),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
