import 'package:flutter/material.dart';
import 'package:mero_career/views/recruiters/home/screen/all_recent_application_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';
import '../screen/home_screen.dart';
import 'applicants_details.dart';

class RecentApplication extends StatefulWidget {
  const RecentApplication({
    super.key,
    required this.widget,
  });

  final RecruiterStats widget;

  @override
  State<RecentApplication> createState() => _RecentApplicationState();
}

class _RecentApplicationState extends State<RecentApplication> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRecentApplication();
    });
  }

  Future<void> getRecentApplication() async {
    await Provider.of<JobProvider>(context, listen: false)
        .getRecentApplicants("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    fontSize: 17.5,
                    letterSpacing: 0.4),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllRecentApplicationScreen()));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer<JobProvider>(builder: (context, provider, child) {
              final recentApplicants = provider.recentApplicants;
              if (recentApplicants!.isEmpty) {
                return SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "No Applicants Found !",
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
              }
              return Row(
                children: recentApplicants.take(10).map((applicant) {
                  return Row(
                    children: [
                      ApplicantsDetails(
                          size: widget.widget.size, data: applicant),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  );
                }).toList(),
              );
            })),
      ],
    );
  }
}
