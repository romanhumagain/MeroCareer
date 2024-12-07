import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_provider.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/views/shared/modal/show_degree_modal.dart';
import 'package:mero_career/views/shared/modal/show_job_level_modal.dart';
import 'package:mero_career/views/shared/modal/show_job_type_modal.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../models/job/job_category_model.dart';
import '../../../../services/job_services.dart';
import '../../../shared/login/login_page.dart';
import '../../../shared/modal/show_job_category_modal.dart';
import '../../../widgets/custom_flushbar_message.dart';
import '../../../widgets/job_post_textfield.dart';

class RecruiterJobPostScreen extends StatefulWidget {
  const RecruiterJobPostScreen({super.key});

  @override
  State<RecruiterJobPostScreen> createState() => _RecruiterJobPostScreenState();
}

class _RecruiterJobPostScreenState extends State<RecruiterJobPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _noOfVacancyController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _jobRequirementsController =
      TextEditingController();
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();

  String _selectedDegree = "";
  String _selectedCategory = "";
  String _selectedCategoryId = "";
  String _selectedJobType = "";
  String _selectedJobLevel = "";
  int _experience = 0;

  final TextEditingController _skillController = TextEditingController();
  List<String> skills = [];

  void _addSkill() {
    if (_skillController.text.trim().isNotEmpty) {
      setState(() {
        skills.add(_skillController.text.trim());
        _skillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      skills.remove(skill);
    });
  }

  late Future<List<JobCategory>> _jobCategories;

  @override
  void initState() {
    super.initState();
    _jobCategories = JobServices().getJobCategories();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _deadlineController.text = selectedDate.toIso8601String().split('.')[0];
      });
    }
  }

  Map<String, dynamic> generateJobPostData() {
    return {
      "job_title": _jobTitleController.text,
      "no_of_vacancy": int.tryParse(_noOfVacancyController.text) ?? 0,
      "degree": _selectedDegree,
      "deadline": _deadlineController.text,
      "job_type": _selectedJobType,
      "job_level": _selectedJobLevel,
      "job_requirement": _jobRequirementsController.text,
      "category": int.tryParse(_selectedCategoryId) ?? 0,
      "required_skills": skills,
      "salary_range": (_minSalaryController.text.isNotEmpty &&
              _maxSalaryController.text.isNotEmpty)
          ? "${_minSalaryController.text}-${_maxSalaryController.text}"
          : "",
      "experience": _experience,
    };
  }

  void _handleJobPost() async {
    Map<String, dynamic> formData = generateJobPostData();
    AuthServices authServices = AuthServices();

    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedCategoryId == "") {
        showCustomFlushbar(
            context: context,
            message: "Please select job category",
            type: MessageType.warning);
        return;
      } else if (_selectedDegree == "") {
        showCustomFlushbar(
            context: context,
            message: "Please select degree required for job",
            type: MessageType.warning);
        return;
      } else if (_selectedJobType == "") {
        showCustomFlushbar(
            context: context,
            message: "Please select job type",
            type: MessageType.warning);
        return;
      } else if (_selectedJobLevel == "") {
        showCustomFlushbar(
            context: context,
            message: "Please select job level",
            type: MessageType.warning);
        return;
      } else {
        try {
          final JobServices jobServices = JobServices();
          final jobProvider = Provider.of<JobProvider>(context, listen: false);
          final response = await jobProvider.postJob(formData);
          if (response?.statusCode == 201) {
            showCustomFlushbar(
                context: context,
                message: "Job posted successfully!",
                type: MessageType.success);
            clearJobPostFields();
          } else if (response?.statusCode == 400) {
            showCustomFlushbar(
              context: context,
              message: "Sorry, couldn't post job. please try again !",
              type: MessageType.error,
            );
          } else if (response?.statusCode == 401) {
            showCustomFlushbar(
              context: context,
              message: "Session expired! Please log in to continue.",
              type: MessageType.error,
            );

            Timer(const Duration(seconds: 3), () {
              authServices.logoutUser();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          } else {
            final responseData = json.decode(response!.body);
            showCustomFlushbar(
                context: context,
                message: responseData['message'] ?? "Failed to post job",
                type: MessageType.error);
          }
        } catch (e) {
          showCustomFlushbar(
              context: context,
              message: "An error occurred: $e",
              type: MessageType.error);
        }
      }
    }
  }

  void clearJobPostFields() {
    _jobTitleController.clear();
    _noOfVacancyController.clear();
    _deadlineController.clear();
    _jobRequirementsController.clear();
    _minSalaryController.clear();
    _maxSalaryController.clear();
    _skillController.clear();

    _selectedDegree = "";
    _selectedCategory = "";
    _selectedCategoryId = "";
    _selectedJobType = "";
    _selectedJobLevel = "";
    _experience = 0;
    skills.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4,
              ),
              Text(
                "Basic Job Info",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "Please fill all the required job information properly",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(
                height: 10,
              ),

              // for the basic job info
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              JobPostTextfield(
                                controller: _jobTitleController,
                                labelText: "Job Title",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Job Title cannot be empty !';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.work,
                                verticalContentPadding: 11.5,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              JobPostTextfield(
                                controller: _noOfVacancyController,
                                labelText: "No of Vacancy",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please provide No of Vacancy for this job';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.people_outlined,
                                verticalContentPadding: 11.5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SelectContainer(
                                        isSelected: _selectedCategory == ""
                                            ? false
                                            : true,
                                        selectText: _selectedCategory == ""
                                            ? "Select Job Category"
                                            : _selectedCategory,
                                        onTap: () {
                                          _showJobCategoryModal(context);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      SelectContainer(
                                        isSelected: _selectedDegree == ""
                                            ? false
                                            : true,
                                        selectText: _selectedDegree == ""
                                            ? "Select Degree"
                                            : _selectedDegree,
                                        onTap: () {
                                          _showEducationCategoryModalSheet(
                                              context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: AbsorbPointer(
                                  child: JobPostTextfield(
                                    controller: _deadlineController,
                                    labelText: "Application Deadline",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select deadline for this job';
                                      }
                                      return null;
                                    },
                                    prefixIcon: Icons.calendar_month,
                                    verticalContentPadding: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      SelectContainer(
                                        isSelected: _selectedJobType == ""
                                            ? false
                                            : true,
                                        selectText: _selectedJobType == ""
                                            ? "Select Job Type"
                                            : _selectedJobType,
                                        onTap: () {
                                          _showJobTypeModalSheet(context);
                                        },
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      SelectContainer(
                                        isSelected: _selectedJobLevel == ""
                                            ? false
                                            : true,
                                        selectText: _selectedJobLevel == ""
                                            ? "Select Job Level"
                                            : _selectedJobLevel,
                                        onTap: () {
                                          _showJobLevelModalSheet(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Required Professional Skills",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "provide all the required skills for job !",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontSize: 11),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          validator: (value) {
                                            if (skills.isEmpty) {
                                              return 'Please provide all the required skills for job !';
                                            }
                                            return null;
                                          },
                                          controller: _skillController,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter a skill (e.g., Design, Python)",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5,
                                                  color: Colors.grey,
                                                ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 16.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          _addSkill();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons.add_circle_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Add",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    spacing: 10.0,
                                    runSpacing: 4.0,
                                    children: skills.map((skill) {
                                      return Chip(
                                        label: Text(
                                          skill,
                                          style: TextStyle(
                                            color: Colors.blue.shade800,
                                            // Text color
                                            fontWeight: FontWeight
                                                .w500, // Make the text slightly bold
                                          ),
                                        ),
                                        backgroundColor: Colors.blue.shade50,
                                        // Background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // Rounded corners
                                          side: BorderSide(
                                            color: Colors
                                                .blue.shade100, // Border color
                                          ),
                                        ),
                                        deleteIcon: Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.red, // Icon color
                                        ),
                                        onDeleted: () => _removeSkill(skill),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MyDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Page Title
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text(
                                    "Add Job Requirements",
                                    style: TextStyle(
                                        fontSize: 20.5,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Please provide detailed job requirements to help candidates understand the role better.",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                            ),
                            SizedBox(height: 10),

                            // Job Requirements TextArea
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please provide job requirements detail";
                                  }
                                  return null;
                                },
                                controller: _jobRequirementsController,
                                maxLines: 8,
                                // Makes the TextField expandable
                                decoration: InputDecoration(
                                  labelText: "Job Requirements",
                                  hintText: "Enter the job requirements here",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                  // Set hint text color to grey
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12), // Rounded corners
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    // Rounded corners when focused
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                        MyDivider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),

                              // Heading
                              Text(
                                "Experience Required",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontSize: 19.5,
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 4),

                              // Subheading
                              Text(
                                "Please select the minimum years of experience required for this role.",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              SizedBox(height: 16),

                              // Experience Level Dropdown
                              DropdownButtonFormField<int>(
                                value: _experience,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please Select Experience';
                                  }
                                  return null;
                                },
                                dropdownColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                decoration: InputDecoration(
                                  labelText:
                                      'Select Required Experience (in years)',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        fontSize: 15,
                                        letterSpacing: 0.5,
                                        color: isDarkMode
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade700,
                                      ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                items: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                                    .map((exp) => DropdownMenuItem<int>(
                                          value: exp,
                                          child: Text('$exp years'),
                                        ))
                                    .toList(),
                                onChanged: (int? value) {
                                  setState(() {
                                    _experience = value!;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),

                                    // Heading
                                    Text(
                                      "Salary Range (Optional)",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              fontSize: 19.5,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 4),

                                    // Subheading
                                    Text(
                                      "Enter the salary range for this job position. This is optional.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    SizedBox(height: 15),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _minSalaryController,
                                            decoration: InputDecoration(
                                              labelText: 'Min Salary',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    fontSize: 15,
                                                    letterSpacing: 0.5,
                                                    color: isDarkMode
                                                        ? Colors.grey.shade500
                                                        : Colors.grey.shade700,
                                                  ),
                                              prefixIcon:
                                                  Icon(Icons.attach_money),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal: 10),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text("-"),
                                        SizedBox(width: 10),

                                        // Max Salary Input
                                        Expanded(
                                          child: TextField(
                                            controller: _maxSalaryController,
                                            decoration: InputDecoration(
                                              labelText: 'Max Salary',
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                    fontSize: 15,
                                                    letterSpacing: 0.5,
                                                    color: isDarkMode
                                                        ? Colors.grey.shade500
                                                        : Colors.grey.shade700,
                                                  ),
                                              prefixIcon:
                                                  Icon(Icons.attach_money),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 9,
                                                      horizontal: 10),
                                            ),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        MyButton(
                            color: Colors.blue,
                            width: size.width / 1.2,
                            height: 45,
                            text: "Post Job",
                            onTap: () {
                              _handleJobPost();
                            }),
                        SizedBox(
                          height: 26,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showEducationCategoryModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ShowDegreeModal(
          title: 'Education',
          selectedValue: _selectedDegree,
          onValueSelected: (String selectedDegree) {
            setState(() {
              _selectedDegree = selectedDegree;
            });
          },
        );
      },
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
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: isSelected ? Colors.blue.shade400 : null,
                    border: !isSelected ? Border.all(color: Colors.grey) : null,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
