import 'package:flutter/material.dart';
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/basic_job_info.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/job_requirements_details.dart';
import 'package:mero_career/views/recruiters/job_post/widgets/professional_skills.dart';

import '../../../../models/job/job_post_model.dart';
import '../../../../models/job/skill_model.dart';
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

  double get _progress => (_currentPage + 1) / _totalSteps;

  final GlobalKey<FormState> _basicInfoKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _skillsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _requirementsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _experienceKey = GlobalKey<FormState>();

  JobPost jobPost = JobPost(
    jobTitle: '',
    noOfVacancies: 0,
    jobCategory: JobCategory(id: 0, category: ''),
    degree: '',
    deadline: DateTime.now(),
    jobType: '',
    jobLevel: '',
    skills: [],
    jobRequirements: '',
    experience: 0,
    salaryRange: '',
    id: 0,
  );

  void _handleSubmission() {
    print({
      "title": jobPost.jobTitle,
      "no of vacancies": jobPost.noOfVacancies,
      "job category": jobPost.jobCategory.category,
      "degree": jobPost.degree,
      "deadline": jobPost.deadline,
      "job type": jobPost.jobType,
      "job level": jobPost.jobLevel,
      // "skills": jobPost.skills.join(", "),
      "job requirements": jobPost.jobRequirements,
      "experience": jobPost.experience,
      "salary range": jobPost.salaryRange,
      "id": jobPost.id,
    });
  }

  void updateSkills(List<String> newSkills) {
    setState(() {
      setState(() {
        jobPost.skills = newSkills.map((skill) => Skill(name: skill)).toList();
      });
    });
  }

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
                  BasicJobInfo(
                    jobPost: jobPost,
                    formKey: _basicInfoKey,
                  ),
                  ProfessionalSkills(
                    jobPost: jobPost,
                    formKey: _skillsKey,
                    onSkillsUpdated: updateSkills,
                  ),
                  JobRequirementsDetails(
                    jobPost: jobPost,
                    formKey: _requirementsKey,
                  ),
                  ExperienceSalaryDetails(
                    jobPost: jobPost,
                    formKey: _experienceKey,
                  )
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
                          if (validateCurrentStep()) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        }),
                  if (_currentPage == _totalSteps - 1)
                    PageControllerButton(
                        size: size,
                        text: "Submit",
                        onTap: () {
                          // if (validateAllForms()) {
                          //   print("Job Post Submitted: ${jobPost.jobTitle}");
                          // }
                          _handleSubmission();
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Validate the current step
  bool validateCurrentStep() {
    switch (_currentPage) {
      case 0:
        return _basicInfoKey.currentState?.validate() ?? false;
      case 1:
        return _skillsKey.currentState?.validate() ?? false;
      case 2:
        return _requirementsKey.currentState?.validate() ?? false;
      case 3:
        return _experienceKey.currentState?.validate() ?? false;
      default:
        return false;
    }
  }

  // Validate all forms during submission
  bool validateAllForms() {
    return _basicInfoKey.currentState?.validate() ??
        false && _skillsKey.currentState!.validate() ??
        false && false && _experienceKey.currentState!.validate() ??
        false;
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
