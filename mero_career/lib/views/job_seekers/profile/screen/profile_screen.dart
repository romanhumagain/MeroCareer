import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/basic_details_card.dart';
import '../widgets/career_preference_card.dart';
import '../widgets/profile_heading_section.dart';
import '../widgets/profile_setup_analysis_section.dart';
import '../widgets/profile_summary_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCareerPreference();
    fetchProfileAnalysis();
    getAppliedJobCount();
  }

  // function to fetch the career preference
  void getAppliedJobCount() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .getAppliedJobCount();
  }

  // function to fetch the career preference
  void fetchCareerPreference() async {
    await Provider.of<JobSeekerProvider>(context, listen: false)
        .fetchCareerPreference(context);
  }

  void fetchProfileAnalysis() async {
    final provider = Provider.of<ProfileSetupProvider>(context, listen: false);
    await provider.fetchProfileAnalysis();
    setState(() {
      _isLoading = provider.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_isLoading) {
      return Scaffold();
    }
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeadingSection(),
              Divider(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              SizedBox(height: 10),
              ProfileSetupAnalysisSection(size: size),
              SizedBox(height: 10),
              BasicDetailsCard(size: size),
              SizedBox(
                height: 15,
              ),
              CareerPreferenceCard(size: size),
              SizedBox(
                height: 15,
              ),
              ProfileSummary(size: size),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
