import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../services/auth_services.dart';
import '../../../../../services/job_seeker_job_services.dart';
import '../../../../shared/login/login_page.dart';
import '../../../../widgets/custom_flushbar_message.dart';
import '../../widgets/job_details_card.dart';

class CompanyJobLists extends StatefulWidget {
  final String companyName;
  final int recruiterId;

  const CompanyJobLists(
      {super.key, required this.companyName, required this.recruiterId});

  @override
  State<CompanyJobLists> createState() => _CompanyJobListsState();
}

class _CompanyJobListsState extends State<CompanyJobLists> {
  late Future<Map<String, dynamic>?> _recruiterInfo;

  @override
  void initState() {
    super.initState();
    _recruiterInfo = _getRecruiterInfo();
  }

  JobSeekerJobServices jobServices = JobSeekerJobServices();

  Future<Map<String, dynamic>?> _getRecruiterInfo() async {
    try {
      final response = await jobServices.getRecruiterInfo(widget.recruiterId);
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
      print("Error getting recruiter $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.companyName),
          toolbarHeight: 65,
        ),
        body: FutureBuilder(
            future: _recruiterInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error Occurs: ${snapshot.error}"),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4),
                  ),
                );
              } else {
                final recruiterDetails = snapshot.data;
                return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        // Job image at the top
                        SizedBox(
                          width: size.width,
                          height: size.height / 6.9,
                          child: Image.asset(
                            'assets/images/job_details/hiring2.webp',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Company info
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(
                                image: recruiterDetails?[
                                            'company_profile_image'] !=
                                        null
                                    ? NetworkImage(
                                        "${recruiterDetails?['company_profile_image']}")
                                    : AssetImage(
                                            'assets/images/default_company_pic.png')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.error, // Fallback for errors
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recruiterDetails?['company_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    recruiterDetails?['company_type'],
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13.5),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TabBar(
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.blue,
                            dividerColor:
                                Theme.of(context).colorScheme.surfaceContainer,
                            tabs: const [
                              Tab(
                                icon: Icon(Icons.info_outline),
                                text: "About",
                              ),
                              Tab(
                                icon: Icon(Icons.info_outline),
                                text: "Jobs Opening ",
                              )
                            ]),
                        Expanded(
                          child: TabBarView(
                            children: [
                              AboutCompany(
                                aboutCompany:
                                    recruiterDetails?['company_summary'],
                              ),
                              JobOpeningLists(
                                recruiterId: recruiterDetails?['id'],
                              )
                            ],
                          ),
                        )
                      ],
                    ));
              }
            }));
  }
}

class AboutCompany extends StatelessWidget {
  final String aboutCompany;

  const AboutCompany({super.key, required this.aboutCompany});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        aboutCompany,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
            ),
      ),
    );
  }
}

class JobOpeningLists extends StatefulWidget {
  final int recruiterId;

  const JobOpeningLists({super.key, required this.recruiterId});

  @override
  State<JobOpeningLists> createState() => _JobOpeningListsState();
}

class _JobOpeningListsState extends State<JobOpeningLists> {
  late Future<List<dynamic>?> _jobListing;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobListing = getJobLists();
  }

  String _listJobsBy = "active";
  final List<String> _filterList = ['active', 'closed'];

  JobSeekerJobServices jobServices = JobSeekerJobServices();

  Future<List<dynamic>?> getJobLists() async {
    try {
      final response = await jobServices.fetchJobPosts(
          recruiterId: widget.recruiterId, filer_by: _listJobsBy);
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
      print("Error getting job lists $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
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
                      _jobListing =
                          getJobLists(); // Re-fetch data on filter change
                    });
                  },
                  selectedColor:
                      _listJobsBy == "active" ? Colors.green : Colors.red,
                  padding: EdgeInsets.all(4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>?>(
            future: _jobListing,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "An error occurred. Please try again.",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!;
                if (data.isEmpty) {
                  return Center(
                    child: Text(
                      "No jobs found.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return JobDetailsCard(
                      size: size,
                      cardColor: cardColor,
                      tertiaryColor: tertiaryColor,
                      job: data[index],
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No data available.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
