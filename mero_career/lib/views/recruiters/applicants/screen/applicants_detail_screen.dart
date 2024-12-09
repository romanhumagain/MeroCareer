import 'package:flutter/material.dart';

import '../../home/widgets/applicants_details.dart';

class ApplicantsDetailScreen extends StatefulWidget {
  final String jobName;

  const ApplicantsDetailScreen({super.key, required this.jobName});

  @override
  State<ApplicantsDetailScreen> createState() => _ApplicantsDetailScreenState();
}

class _ApplicantsDetailScreenState extends State<ApplicantsDetailScreen> {
  String _listJobsBy = "all";
  final List<String> _filterList = [
    'all',
    'Under Review',
    'Reviewed',
    'Shortlisted',
    'Accepted'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        toolbarHeight: 65,
        title: Text(widget.jobName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                width: size.width,
                height: size.height / 6.5,
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
                        "Review and Connect with Top Talent",
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
                        "Your next great hire could be among these applicants. Take the first step today!",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14, color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ApplicantsDetails(size: size),
                  // ApplicantsDetails(size: size),
                  // ApplicantsDetails(size: size),
                  // ApplicantsDetails(size: size),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
