import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/services/job_seeker_job_services.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/job_seekers/home/screen/jobs_by_organization/company_job_lists.dart';

import '../../../../../services/auth_services.dart';
import '../../../../shared/login/login_page.dart';
import '../../../../widgets/custom_flushbar_message.dart';

class ViewJobsByCompany extends StatefulWidget {
  const ViewJobsByCompany({super.key});

  @override
  State<ViewJobsByCompany> createState() => _ViewJobsByCompanyState();
}

class _ViewJobsByCompanyState extends State<ViewJobsByCompany> {
  late Future<List<dynamic>?> _jobOpeningOrganizations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobOpeningOrganizations = _getjobOpeningOrganization();
  }

  JobSeekerJobServices jobServices = JobSeekerJobServices();

  Future<List<dynamic>?> _getjobOpeningOrganization() async {
    try {
      final response = await jobServices.fetchJobByOrganization();
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
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: _jobOpeningOrganizations,
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
                  final _jobOpeningOrganizations = snapshot.data;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _jobOpeningOrganizations!.map((jobOpening) {
                        if (jobOpening['recruiters']?.isNotEmpty) {
                          return AvailableCompany(
                            size: size,
                            jobOpening: jobOpening,
                          );
                        }
                        return SizedBox();
                      }).toList());
                }
              }),
        ),
      ),
    );
  }
}

class AvailableCompany extends StatelessWidget {
  final Map<String, dynamic> jobOpening;

  const AvailableCompany(
      {super.key, required this.size, required this.jobOpening});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            jobOpening['category'],
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 18.5),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: jobOpening['recruiters'].map<Widget>((recruiter) {
                  return CompanyCard(
                    size: size,
                    recruiter: recruiter,
                  );
                }).toList()),
          )
        ],
      ),
    );
  }
}

class CompanyCard extends StatelessWidget {
  final Map<String, dynamic> recruiter;

  const CompanyCard({super.key, required this.size, required this.recruiter});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompanyJobLists(
                        companyName: recruiter['company_name'],
                        recruiterId: recruiter['id'],
                      )));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          width: size.width / 3.36,
          height: size.height / 6.2,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: recruiter['company_profile_image'] != null
                      ? NetworkImage(
                          "http://10.0.2.2:8000${recruiter['company_profile_image']}")
                      : AssetImage('assets/images/default_company_pic.png')
                          as ImageProvider,
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.error, // Fallback for errors
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                recruiter['company_name'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2),
              ),
              Text(
                recruiter['company_type'],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
