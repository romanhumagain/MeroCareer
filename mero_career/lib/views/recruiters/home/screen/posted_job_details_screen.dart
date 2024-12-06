import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/job_services.dart';
import 'package:mero_career/views/shared/login/login_page.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';

import '../../../../utils/date_formater.dart';
import '../../../job_seekers/home/screen/job_details_screen.dart';
import '../../applicants/screen/applicants_detail_screen.dart';

class PostedJobDetailsScreen extends StatefulWidget {
  final int id;

  const PostedJobDetailsScreen({super.key, required this.id});

  @override
  State<PostedJobDetailsScreen> createState() => _PostedJobDetailsScreenState();
}

class _PostedJobDetailsScreenState extends State<PostedJobDetailsScreen> {
  late Future<Map<String, dynamic>> jobDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jobDetails = fetchJobDetails();
  }

  JobServices jobServices = JobServices();

  Future<Map<String, dynamic>> fetchJobDetails() async {
    try {
      final response = await jobServices.fetchJobDetails(widget.id);
      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        return responseData; // Return the decoded data
      } else if (response.statusCode == 401) {
        AuthServices authServices = AuthServices();
        await authServices.logoutUser();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else if (response.statusCode == 404) {
        showCustomFlushbar(
            context: context,
            message: "Job Details not Found !",
            type: MessageType.error);

        await Future.delayed(Duration(seconds: 2));
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error:- $e");
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return FutureBuilder(
        future: jobDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Scaffold(
              body: Center(
                  child: Text(
                      'No job details available')), // Handle the case with no data
            );
          } else {
            final jobDetails = snapshot.data!;
            return DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  toolbarHeight: 70,
                  title: Text(
                    jobDetails['job_title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.5,
                        letterSpacing: 0.4),
                  ),
                ),
                body: Stack(children: [
                  Column(
                    children: [
                      SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  jobDetails['job_title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(fontSize: 20.5),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  formatDeadline(jobDetails['deadline']),
                                  style: TextStyle(
                                      color: jobDetails['is_active']
                                          ? Colors.green
                                          : Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // TabBar and TabBarView
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 12),
                          child: Column(
                            children: [
                              const TabBar(
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.blue,
                                tabs: [
                                  Tab(
                                    icon: Icon(Icons.info_outline),
                                    text: "Job Info",
                                  ),
                                  Tab(
                                    icon: Icon(Icons.list_alt),
                                    text: "Requirements",
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 14),
                                  child: TabBarView(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          BasicJobInfo(
                                            size: size,
                                            jobDetails: jobDetails,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceContainer,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RequirementSkills(
                                              jobDetails: jobDetails),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceContainer,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          JobSpecification(
                                            size: size,
                                            jobDetails: jobDetails,
                                          )
                                        ],
                                      ),
                                      Text(
                                        jobDetails['job_requirement'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: size.height / 13.5,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ApplicantsDetailScreen(
                                              jobName: "Flutter Developer",
                                            )));
                              },
                              child: Container(
                                width: size.width / 1.4,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "View Applicants",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          }
        });
  }
}

class RequirementSkills extends StatelessWidget {
  final Map<String, dynamic> jobDetails;

  const RequirementSkills({
    super.key,
    required this.jobDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Professional Skill Required",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 17.5),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: jobDetails['skills_display'].map<Widget>((skill) {
              return SkillCard(
                skill: skill,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class JobSpecification extends StatelessWidget {
  const JobSpecification({
    super.key,
    required this.size,
    required this.jobDetails,
  });

  final Size size;
  final Map<String, dynamic> jobDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job Specification",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(
            size: size,
            data: "Education Required",
            value: jobDetails['degree']),
        SizedBox(
          height: 4,
        ),
        JobInfoTable(
            size: size,
            data: "Experience",
            value: "${jobDetails['experience'] ?? 0} year"),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(
            size: size,
            data: "Salary",
            value: jobDetails['salary_range'] ?? "Not Disclosed"),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class BasicJobInfo extends StatelessWidget {
  const BasicJobInfo({
    super.key,
    required this.size,
    required this.jobDetails,
  });

  final Size size;
  final Map<String, dynamic> jobDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Job Information",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 15,
        ),
        JobInfoTable(
          size: size,
          data: "No. of Vacancy",
          value: jobDetails['no_of_vacancy'].toString(),
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Available for ",
          value: jobDetails['job_type'],
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Category",
          value: jobDetails['category_name'],
        ),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(
          size: size,
          data: "Job Level",
          value: jobDetails['job_level'],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class JobInfoTable extends StatelessWidget {
  final Size size;
  final String data;
  final String value;

  const JobInfoTable(
      {super.key, required this.size, required this.data, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: size.width / 3,
          child: Text(
            data,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        SizedBox(
          width: size.width / 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.4),
          ),
        )
      ],
    );
  }
}
