import 'package:flutter/material.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/basic_job_info.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/job_requirements_details.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/professional_skills.dart';

import '../widgets/experience_salary_details.dart';

class JobPostScreen extends StatefulWidget {
  const JobPostScreen({super.key});

  @override
  State<JobPostScreen> createState() => _JobPostScreenState();
}

class _JobPostScreenState extends State<JobPostScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalSteps = 4;

  // to calculate progress in the progress bar
  double get _progress => (_currentPage + 1) / _totalSteps;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(1.5, 1.5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue,
                  ),
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  BasicJobInfo(),
                  ProfessionalSkills(),
                  JobRequirementsDetails(),
                  ExperienceSalaryDetails()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: _currentPage == 0
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    PageControllerButton(
                      size: size,
                      text: "Back",
                      onTap: () {
                        _pageController.previousPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                    ),
                  if (_currentPage < _totalSteps - 1)
                    PageControllerButton(
                        size: size,
                        text: "Next",
                        onTap: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }),
                  if (_currentPage == _totalSteps - 1)
                    PageControllerButton(
                        size: size, text: "Submit", onTap: () {})
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageControllerButton extends StatelessWidget {
  final Function onTap;
  final String text;

  const PageControllerButton(
      {super.key, required this.size, required this.onTap, required this.text});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.all(3),
            width: size.width / 5.5,
            height: size.height / 24,
            decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Form steps
Widget _buildStepOne() {
  return Center(
    child: Text("Step 1: Personal Information"),
  );
}

Widget _buildStepTwo() {
  return Center(
    child: Text("Step 2: Address Details"),
  );
}

Widget _buildStepThree() {
  return Center(
    child: Text("Step 3: Confirm Details"),
  );
}
