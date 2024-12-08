import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/job_seeker_job_services.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/login/login_page.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../widgets/job_details_card.dart';

class JobsByCategoryScreen extends StatefulWidget {
  final JobCategory category;

  const JobsByCategoryScreen({super.key, required this.category});

  @override
  State<JobsByCategoryScreen> createState() => _JobsByCategoryScreenState();
}

class _JobsByCategoryScreenState extends State<JobsByCategoryScreen> {
  late Future<List<dynamic>?> _jobList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobList = getJobLists();
  }

  JobSeekerJobServices jobServices = JobSeekerJobServices();
  String _listJobsBy = "active";
  final List<String> _filterList = ['active', 'closed'];

  Future<List<dynamic>?> getJobLists() async {
    try {
      final response =
          await jobServices.fetchJobByCategory(widget.category.id, _listJobsBy);
      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        return responseData;
      } else if (response.statusCode == 401) {
        AuthServices authServices = AuthServices();
        await authServices.logoutUser();

        showCustomFlushbar(
            context: context,
            message: "Session Expired! Please login again",
            type: MessageType.error);
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      }
      return null;
    } catch (e) {
      return null;
      print("Error getting job lists $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 8,
              decoration: BoxDecoration(
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
                      widget.category.category,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 21.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Latest job vacancy in ${widget.category.category} in Nepal. Click on the job that interests you, and apply on jobs.",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 13.5, color: Colors.grey.shade200),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          _listJobsBy = selected ? filter : 'active';
                          _jobList = getJobLists();
                        });
                      },
                      selectedColor:
                          _listJobsBy == "active" ? Colors.green : Colors.red,
                      padding: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: FutureBuilder(
                  future: _jobList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "0 Results",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                        "0 Results",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      );
                    } else {
                      final jobCount = snapshot.data!.length;
                      return Text(
                        "$jobCount Results",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      );
                    }
                  },
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            FutureBuilder(
                future: _jobList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No jobs found for this category !",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                    );
                  } else {
                    final jobLists = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: jobLists!.map((job) {
                          return JobDetailsCard(
                            size: size,
                            cardColor: cardColor,
                            tertiaryColor: tertiaryColor,
                            job: job,
                          );
                        }).toList(),
                      ),
                    );
                  }
                }),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
