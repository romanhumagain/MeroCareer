import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../models/job/job_category_model.dart';
import '../../../../providers/job_seeker_provider.dart';
import '../../../../services/job_services.dart';
import '../../../shared/modal/show_job_category_modal.dart';
import '../../../shared/modal/show_job_level_modal.dart';
import '../../../shared/modal/show_job_type_modal.dart';
import '../widgets/career_preference_card.dart';

class CareerPreferenceScreen extends StatefulWidget {
  const CareerPreferenceScreen({super.key});

  @override
  State<CareerPreferenceScreen> createState() => _CareerPreferenceScreenState();
}

class _CareerPreferenceScreenState extends State<CareerPreferenceScreen> {
  late Future<List<JobCategory>> _jobCategories;

  // Declaring the variables
  String _selectedCategory = "";
  String _selectedCategoryId = "";
  String _selectedJobType = "";
  String _selectedJobLevel = "";

  @override
  void initState() {
    super.initState();
    _jobCategories = JobServices().getJobCategories();
  }

  @override
  Widget build(BuildContext context) {
    final careerPrefProvider = Provider.of<ProfileSetupProvider>(context);

    // Initialize TextControllers for the fields
    TextEditingController jobTitleController = TextEditingController(
        text: careerPrefProvider.careerPreference?['prefered_job_title']);
    TextEditingController jobLocationController = TextEditingController(
        text: careerPrefProvider.careerPreference?['prefered_job_location']);
    TextEditingController expectedSalaryController = TextEditingController(
        text:
            careerPrefProvider.careerPreference?['expected_salary'].toString());

    // Initialize selected values from the provider if it's not already set
    if (_selectedCategory.isEmpty &&
        careerPrefProvider.careerPreference?['prefered_job_category_name'] !=
            null) {
      _selectedCategory =
          careerPrefProvider.careerPreference?['prefered_job_category_name'] ??
              "";
      _selectedCategoryId =
          careerPrefProvider.careerPreference?['prefered_job_category_id'] ??
              "";
    }

    if (_selectedJobType.isEmpty &&
        careerPrefProvider.careerPreference?['prefered_job_type'] != null) {
      _selectedJobType =
          careerPrefProvider.careerPreference?['prefered_job_type'] ?? "";
    }

    if (_selectedJobLevel.isEmpty &&
        careerPrefProvider.careerPreference?['prefered_job_level'] != null) {
      _selectedJobLevel =
          careerPrefProvider.careerPreference?['prefered_job_level'] ?? "";
    }

    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text("Career Preference",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 21)),
                  SizedBox(height: 8),
                  Text("Add details about your preferred job profile.",
                      style: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      children: [
                        PreferenceTextField(
                          controller: jobTitleController,
                          labelText: "Preferred Job Title",
                        ),
                        SizedBox(height: 15),
                        PreferenceTextField(
                          controller: jobLocationController,
                          labelText: "Preferred Job Location",
                        ),
                        SizedBox(height: 15),
                        PreferenceTextField(
                          controller: expectedSalaryController,
                          labelText: "Expected Salary (/Month)",
                        ),
                        SizedBox(height: 20),
                        SelectContainer(
                          isSelected: _selectedCategory.isNotEmpty,
                          selectText: _selectedCategory.isEmpty
                              ? "Select Job Category"
                              : _selectedCategory,
                          onTap: () {
                            _showJobCategoryModal(context);
                          },
                        ),
                        SizedBox(height: 20),
                        SelectContainer(
                          isSelected: _selectedJobLevel.isNotEmpty,
                          selectText: _selectedJobLevel.isEmpty
                              ? "Select Job Level"
                              : _selectedJobLevel,
                          onTap: () {
                            _showJobLevelModalSheet(context);
                          },
                        ),
                        SizedBox(height: 20),
                        SelectContainer(
                          isSelected: _selectedJobType.isNotEmpty,
                          selectText: _selectedJobType.isEmpty
                              ? "Select Job Type"
                              : _selectedJobType,
                          onTap: () {
                            _showJobTypeModalSheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: () {
                      Map<String, dynamic> updatedPreference = {
                        'prefered_job_title': jobTitleController.text.isEmpty
                            ? ""
                            : jobTitleController.text,
                        'prefered_job_location':
                            jobLocationController.text.isEmpty
                                ? ""
                                : jobLocationController.text,
                        'expected_salary': expectedSalaryController.text.isEmpty
                            ? ""
                            : expectedSalaryController.text,
                        'prefered_job_level': _selectedJobLevel,
                        'prefered_job_type': _selectedJobType,
                        'prefered_job_category': _selectedCategoryId,
                      };
                      careerPrefProvider.updateCareerPreference(
                          context, updatedPreference);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: Text("Save Changes",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.5,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJobCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return JobCategoryModal(
          jobCategoriesFuture: _jobCategories,
          selectedCategory: _selectedCategory,
          onCategorySelected: (categoryName, categoryId) {
            setState(() {
              _selectedCategory = categoryName;
              _selectedCategoryId = categoryId;
            });
          },
        );
      },
    );
  }

  void _showJobTypeModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ShowJobTypeModal(
          selectedJobType: _selectedJobType,
          onValueSelected: (String selectedJobType) {
            setState(() {
              _selectedJobType = selectedJobType;
            });
          },
        );
      },
    );
  }

  void _showJobLevelModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ShowJobLevelModal(
          selectedJobLevel: _selectedJobLevel,
          onValueSelected: (String selectedJobLevel) {
            setState(() {
              _selectedJobLevel = selectedJobLevel;
            });
          },
        );
      },
    );
  }
}

class SelectContainer extends StatelessWidget {
  final String selectText;
  final Function onTap;
  final bool isSelected;

  const SelectContainer({
    super.key,
    required this.selectText,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade400 : null,
            border: !isSelected ? Border.all(color: Colors.grey) : null,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? Colors.white
                      : (isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade900)),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.keyboard_arrow_down_outlined,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade900))
          ],
        ),
      ),
    );
  }
}
