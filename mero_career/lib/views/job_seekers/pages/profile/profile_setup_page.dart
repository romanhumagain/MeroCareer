import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/pages/profile/profile_setup_pageview.dart';
import 'package:mero_career/views/widgets/my_button.dart';

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  void handleProfileSetup() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProfileSetupPageview()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          "",
          style:
              Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Clean and inviting motivational message
            Text(
              "Let’s get you ready to shine!",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Complete your profile to unlock personalized job recommendations and kickstart your career journey.",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),

            // Profile setup image for a clean and modern look
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Image.asset(
                'assets/images/profile_setup.png',
                // Make sure this image is clean and matches the theme
                height: 350,
                width: size.width / 1.2,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 45),
            // Button to continue profile setup
            MyButton(
              color: Colors.blue,
              width: size.width / 1.2,
              height: 47,
              text: "Continue",
              onTap: handleProfileSetup,
            ),

            SizedBox(height: 20),

            // Skip option with clear design
            GestureDetector(
              onTap: () {
                // Handle Skip action
              },
              child: Text(
                "Skip for now? You can complete it later.",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.blue.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
