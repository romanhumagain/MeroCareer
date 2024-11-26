import 'package:flutter/material.dart';

import '../widgets/basic_details_card.dart';
import '../widgets/career_preference_card.dart';
import '../widgets/profile_heading_section.dart';
import '../widgets/profile_setup_analysis_section.dart';
import '../widgets/profile_summary_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
