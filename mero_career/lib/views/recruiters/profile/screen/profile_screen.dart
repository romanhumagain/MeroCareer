import 'package:flutter/material.dart';
import 'package:mero_career/providers/recruiter_provider.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/recruiters/profile/widgets/about_company_details.dart';
import 'package:mero_career/views/recruiters/profile/widgets/company_basic_details.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';

class RecruiterProfileScreen extends StatelessWidget {
  const RecruiterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          // profile heading
          CompanyProfileHeadingSection(isDarkMode: isDarkMode),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          SizedBox(
            height: 5,
          ),
          CompanyBasicDetails(size: size),
          SizedBox(
            height: 10,
          ),
          AboutCompanyDetails(size: size),
          SizedBox(
            height: 20,
          ),
          MotivationalMessage(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class CompanyProfileHeadingSection extends StatelessWidget {
  const CompanyProfileHeadingSection({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Consumer<RecruiterProvider>(builder: (context, provider, child) {
            final recruiterData = provider.recruiterProfileDetails;
            return Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: recruiterData?['company_profile_image'] !=
                          null
                      ? NetworkImage(recruiterData?['company_profile_image'])
                      : const AssetImage(
                              'assets/images/company_logo/default_company_pic.png')
                          as ImageProvider,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  recruiterData?['company_name'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  recruiterData?['company_type'],
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 15),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                    ),
                    Text(recruiterData?['address'],
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                fontSize: 15,
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600))
                  ],
                ),
              ],
            );
          }),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          KeyMetricsCards(),
        ],
      ),
    );
  }
}

class KeyMetricsCards extends StatefulWidget {
  const KeyMetricsCards({super.key});

  @override
  State<KeyMetricsCards> createState() => _KeyMetricsCardsState();
}

class _KeyMetricsCardsState extends State<KeyMetricsCards> {
  List metrics = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMatricesData();
  }

  void setMatricesData() async {
    final provider = Provider.of<JobProvider>(context, listen: false);
    await provider.getRecruiterStats();

    final stats = await provider.recruiterStats;

    setState(() {
      metrics = [
        {
          "title": "Jobs Posted",
          "value": stats?['total_job_posting'].toString()
        },
        {
          "title": "Applicants Received",
          "value": stats?['application_received'].toString()
        },
        {
          "title": "Hires Made",
          "value": stats?['accepted_applicant'].toString()
        },
      ];

      isLoading = false;
    });
  }

  Future<void> getRecruiterStats() async {}

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 127,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: metrics.map((metric) {
          return Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      metric["value"]!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      metric["title"]!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MotivationalMessage extends StatelessWidget {
  const MotivationalMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 40,
            color: Colors.blue.shade700,
          ),
          const SizedBox(height: 16),
          Text(
            "Empowering companies to build great teams.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
                fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            "Your ideal candidate is just a click away.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blueGrey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}
