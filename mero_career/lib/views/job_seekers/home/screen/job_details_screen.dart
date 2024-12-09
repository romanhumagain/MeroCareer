import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:mero_career/views/job_seekers/map/screen/company_map.dart';
import 'package:mero_career/views/job_seekers/map/screen/company_map_screen.dart';
import 'package:mero_career/views/widgets/custom_confirmation_message.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/date_formater.dart';

class JobDetailsScreen extends StatefulWidget {
  final int jobId;
  final String jobTitle;

  const JobDetailsScreen(
      {super.key, required this.jobId, required this.jobTitle});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchJobDetails();
  }

  void _fetchJobDetails() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .getJobDetails(widget.jobId);
  }

  void handleSave(Map<String, dynamic> jobData) async {
    final response =
        await Provider.of<JobSeekerJobProvider>(context, listen: false)
            .saveJob(context, jobData);

    if (response?.statusCode == 201) {
      await Provider.of<JobSeekerJobProvider>(context, listen: false)
          .getJobDetails(widget.jobId);
      setState(() {});
    }
  }

  void handleUnsave() async {
    final response =
        await Provider.of<JobSeekerJobProvider>(context, listen: false)
            .unSaveJob(context, widget.jobId);

    if (response?.statusCode == 204) {
      await Provider.of<JobSeekerJobProvider>(context, listen: false)
          .getJobDetails(widget.jobId);
      setState(() {});
    }
  }

  void handleJobApply(Map<String, dynamic> jobData) async {
    final response =
        await Provider.of<JobSeekerJobProvider>(context, listen: false)
            .applyForJob(context, jobData);
  }

  void cancelJobApplication() async {
    final bool confirmed = await showCustomConfirmationDialog(context,
        "Are you sure you want to withdraw your application for this job? Once withdrawn, you may not be considered for this position.");
    if (confirmed) {
      final response =
          await Provider.of<JobSeekerJobProvider>(context, listen: false)
              .cancelJobApplication(context, widget.jobId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

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
            widget.jobTitle,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.5,
                letterSpacing: 0.4),
          ),
        ),
        body:
            Consumer<JobSeekerJobProvider>(builder: (context, provider, child) {
          final jobDetails = provider.jobDetails;
          if (jobDetails!.isEmpty) {
            return Center(
              child: Text("Job details not found !"),
            );
          }
          return Stack(children: [
            Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height / 7.5,
                  child: ClipRRect(
                    child: Image.asset(
                      'assets/images/job_details/hiring2.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Company info
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: jobDetails['recruiter_details']
                                  ['company_profile_image'] !=
                              null
                          ? Image.network(
                              jobDetails['recruiter_details']
                                  ['company_profile_image'],
                              height: 47,
                              width: 45,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/company_logo/leapfrog.jpg',
                              fit: BoxFit.cover,
                              height: 45,
                              width: 45,
                            ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobDetails['recruiter_details']['company_name'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            jobDetails['recruiter_details']['company_type'],
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Job title and save button
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
                                ?.copyWith(fontSize: 20.8),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: jobDetails['is_saved']
                                ? GestureDetector(
                                    onTap: () {
                                      handleUnsave();
                                    },
                                    child: Icon(
                                      Icons.bookmark,
                                      size: 28,
                                      color: Colors.blue,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      handleSave({'job': jobDetails['id']});
                                    },
                                    child: Icon(
                                      Icons.bookmark_border,
                                      size: 28,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      jobDetails['is_active']
                          ? Row(
                              children: [
                                Text(
                                  "Apply Before: ",
                                  style: TextStyle(fontSize: 15.5),
                                ),
                                Text(
                                  formatDeadline(jobDetails['deadline'])
                                      .split(' ')
                                      .sublist(1)
                                      .join(
                                        " ",
                                      ),
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16),
                                )
                              ],
                            )
                          : Text(
                              "Job Closed",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                    ],
                  ),
                ),

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
                            Tab(
                              icon: Icon(Icons.business),
                              text: "Company Profile",
                            ),
                            Tab(
                              icon: Icon(Icons.monetization_on),
                              text: "Salary",
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
                                      height: 15,
                                    ),
                                  ],
                                ),
                                RequirementSkills(
                                  jobRequirements:
                                      jobDetails['job_requirement'],
                                  requiredSkills: jobDetails['skills_display'],
                                ),
                                CompanyProfile(
                                    recruiterDetails:
                                        jobDetails['recruiter_details'],
                                    email: jobDetails['email']),
                                // for salary
                                SalaryDetails(jobDetails: jobDetails)
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
              child: GestureDetector(
                onTap: () {
                  jobDetails['is_active']
                      ? jobDetails['is_applied']
                          ? jobDetails['application_status'] ==
                                      "Under Review" ||
                                  jobDetails['application_status'] == "Reviewed"
                              ? cancelJobApplication()
                              : showCustomFlushbar(
                                  duration: 2200,
                                  context: context,
                                  message:
                                      "Your application has been approved! The recruiter may now proceed with the next steps. You can't cancel now. Try contacting recrutier !",
                                  type: MessageType.error)
                          : handleJobApply({'job': jobDetails['id']})
                      : showCustomFlushbar(
                          duration: 1600,
                          message:
                              "This job has been closed !, you can't apply for this job.",
                          type: MessageType.error,
                          context: context);
                },
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
                        child: Container(
                          width: size.width / 1.4,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: jobDetails['is_active']
                                ? jobDetails['application_status'] == "Accepted"
                                    ? Colors.blue.shade600
                                    : Theme.of(context).primaryColor
                                : Colors.blue.shade300,
                          ),
                          child: Center(
                            child: Text(
                              jobDetails['is_applied']
                                  ? jobDetails['application_status']
                                  : "Apply Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.6),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyMap()));
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompanyMapScreen(
                                        companyAddress:
                                            jobDetails['recruiter_details']
                                                ['address'],
                                        companyName:
                                            jobDetails['recruiter_details']
                                                ['company_name'])));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]);
        }),
      ),
    );
  }
}

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({
    super.key,
    required this.recruiterDetails,
    required this.email,
  });

  final Map<String, dynamic>? recruiterDetails;
  final String email;

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final recruiter = widget.recruiterDetails;
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Profile Image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    recruiter?['company_profile_image'] ??
                        'https://via.placeholder.com/150',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),

                // Company Name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recruiter?['company_name'] ?? 'Company Name',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                    ),
                    SizedBox(height: 8),

                    // Company Type & Phone Number
                    Row(
                      children: [
                        Icon(Icons.business, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          recruiter?['company_type'] ?? 'Company Type',
                          style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.business, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          recruiter?['phone_number'] ?? 'Phone Number',
                          style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          recruiter?['address'] ?? 'Address',
                          style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ],
            ),
            MyDivider(),
            // Links (LinkedIn & Website)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // LinkedIn Link
                if (recruiter?['linkedin_link'] != null)
                  IconButton(
                    icon: Icon(Icons.account_box, color: Colors.blue),
                    onPressed: () {},
                  ),
                // Website Link
                if (recruiter?['website_link'] != null)
                  IconButton(
                    icon: Icon(Icons.language, color: Colors.blue),
                    onPressed: () {},
                  ),
              ],
            ),
            SizedBox(height: 16),
            // Company Summary
            Text(
              _isExpanded
                  ? (recruiter?['company_summary'] ??
                      'Company Summary not available.')
                  : (recruiter?['company_summary']?.length ?? 0) > 100
                      ? "${recruiter?['company_summary']?.substring(0, 100)}..."
                      : (recruiter?['company_summary'] ??
                          'Company Summary not available.'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "Read Less" : "Read More",
                style: TextStyle(color: Colors.blue),
              ),
            ),

            SizedBox(height: 26),

            if (recruiter?['user_details']['is_verified'] == true)
              Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 5),
                  Text(
                    'Verified Recruiter',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SalaryDetails extends StatelessWidget {
  const SalaryDetails({
    super.key,
    required this.jobDetails,
  });

  final Map<String, dynamic>? jobDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Salary",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 18),
        ),
        SizedBox(
          height: 2,
        ),
        MyDivider(),
        SizedBox(
          height: 5,
        ),
        Text(
          jobDetails?['salary_range'] != null
              ? "Salary Range: ${jobDetails?['salary_range']} K/month"
              : "Salary information not disclosed by the recruiter.",
          style: TextStyle(fontSize: 17, letterSpacing: 0.2),
        )
      ],
    );
  }
}

class RequirementSkills extends StatelessWidget {
  final String jobRequirements;
  final List<dynamic> requiredSkills;

  const RequirementSkills(
      {super.key, required this.jobRequirements, required this.requiredSkills});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Basic Requirement",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 18.4),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              jobRequirements,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            MyDivider(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Professional Skill Required",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 17.6),
            ),
            SizedBox(
              height: 16,
            ),
            Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: requiredSkills.map((skill) {
                  return SkillCard(skill: skill);
                }).toList()),
          ],
        ),
      ),
    );
  }
}

class JobSpecification extends StatelessWidget {
  const JobSpecification({
    super.key,
    required this.size,
  });

  final Size size;

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
              ?.copyWith(fontSize: 17.5),
        ),
        SizedBox(
          height: 10,
        ),
        JobInfoTable(
            size: size, data: "Education Required", value: "Under Graduate"),
        SizedBox(
          height: 2,
        ),
        JobInfoTable(size: size, data: "Experience", value: "More than 2 year"),
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
              ?.copyWith(fontSize: 17.5),
        ),
        SizedBox(
          height: 15,
        ),
        JobInfoTable(
          size: size,
          data: "No. of Vacency",
          value: jobDetails['no_of_vacancy'].toString(),
        ),
        SizedBox(
          height: 5,
        ),
        JobInfoTable(
          size: size,
          data: "Available for ",
          value: jobDetails['job_type'],
        ),
        SizedBox(
          height: 5,
        ),
        JobInfoTable(
          size: size,
          data: "Category",
          value: jobDetails['category_name'],
        ),
        SizedBox(
          height: 5,
        ),
        JobInfoTable(
          size: size,
          data: "Degree",
          value: jobDetails['degree'],
        ),
        SizedBox(
          height: 5,
        ),
        JobInfoTable(
          size: size,
          data: "Job Level",
          value: jobDetails['job_level'],
        ),
        SizedBox(
          height: 5,
        ),
        JobInfoTable(
          size: size,
          data: "Experience",
          value: "${jobDetails['experience'].toString()} Years",
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class SkillCard extends StatelessWidget {
  final String skill;

  const SkillCard({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue.shade300,
      ),
      child: Text(
        skill,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
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
                .titleSmall
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 6,
        ),
        SizedBox(
          width: size.width / 2,
          child: Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontSize: 16.5, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
