import 'package:flutter/material.dart';
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/models/job/job_post_model.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/widgets/custom_number_field.dart';
import 'package:mero_career/views/widgets/custom_textfield.dart';

import '../../../../utils/date_formater.dart';

class BasicJobInfo extends StatefulWidget {
  final JobPost jobPost;
  final GlobalKey<FormState> formKey;

  const BasicJobInfo({super.key, required this.jobPost, required this.formKey});

  @override
  State<BasicJobInfo> createState() => _BasicJobInfoState();
}

class _BasicJobInfoState extends State<BasicJobInfo> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _noOfVacancyController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _deadlineController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  final List<Map<String, dynamic>> _categoryList = [
    {"id": 1, "categoryName": "IT & Telecommunication"},
    {"id": 2, "categoryName": "Architecture & Design"},
    {"id": 3, "categoryName": "Teaching & Education"},
    {"id": 4, "categoryName": "Hospital"},
    {"id": 5, "categoryName": "Banking & Insurance"},
    {"id": 6, "categoryName": "Graphic Designing"},
    {"id": 7, "categoryName": "Accounting"},
    {"id": 8, "categoryName": "Construction"},
    {"id": 9, "categoryName": "Others"},
  ];

  final List<Map<String, dynamic>> _degreeNameList = [
    {"id": 1, "degreeName": "Doctorate (Ph.D)"},
    {"id": 2, "degreeName": "Graduate (Masters)"},
    {"id": 3, "degreeName": "Under Graduate (Bachelors)"},
    {"id": 4, "degreeName": "Higher Secondary (+2/A levels)"},
    {"id": 5, "degreeName": "Diploma Certificate"},
    {"id": 6, "degreeName": "School (SEE)"},
    {"id": 7, "degreeName": "Other"},
  ];

  final List<Map<String, dynamic>> _jobTypeList = [
    {"id": 1, "jobType": "Full Time"},
    {"id": 2, "jobType": "Part Time"},
    {"id": 3, "jobType": "Internship"},
    {"id": 4, "jobType": "Remote"},
    {"id": 5, "jobType": "Freelance"},
    {"id": 6, "jobType": "Traineship"},
  ];

  final List<Map<String, dynamic>> _jobLevelList = [
    {"id": 1, "jobLevel": "Top Level"},
    {"id": 2, "jobLevel": "Senior Level"},
    {"id": 3, "jobLevel": "Mid Level"},
    {"id": 4, "jobLevel": "Entry Level"},
    {"id": 5, "jobLevel": "Fresh Graduate"},
  ];

  String _selectedCategory = "";
  String _selectedCategoryId = "";
  String _selectedDegree = "";
  String _selectedJobType = "";
  String _selectedJobLevel = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _jobTitleController.text = widget.jobPost.jobTitle;
    _noOfVacancyController.text = widget.jobPost.noOfVacancies.toString();
    _deadlineController.text = formatDate(widget.jobPost.deadline);
    _selectedCategory = widget.jobPost.jobCategory.category;
    _selectedCategoryId = widget.jobPost.jobCategory.id.toString();
    _selectedDegree = widget.jobPost.degree;
    _selectedJobType = widget.jobPost.jobType;
    _selectedJobLevel = widget.jobPost.jobLevel;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Basic Job Info",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Text(
              "Please fill all the basic job information properly",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Form(
                key: widget.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _jobTitleController,
                      labelText: "Job Title",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Job Title cannot be empty !';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.jobPost.jobTitle = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomNumberField(
                      controller: _noOfVacancyController,
                      labelText: "No of Vacancy",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide No of Vacancy for this job';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.jobPost.noOfVacancies = int.parse(value) ?? 0;
                        });
                      },
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
                              isSelected:
                                  _selectedCategory == "" ? false : true,
                              selectText: _selectedCategory == ""
                                  ? "Select Job Category"
                                  : _selectedCategory,
                              onTap: () {
                                _showJobCategoryModalSheet(context);
                              },
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            SelectContainer(
                              isSelected: _selectedDegree == "" ? false : true,
                              selectText: _selectedDegree == ""
                                  ? "Select Degree"
                                  : _selectedDegree,
                              onTap: () {
                                _showEducationCategoryModalSheet(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _deadlineController,
                            labelText: "Application Deadline",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select deadline for this job';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                widget.jobPost.deadline = value as DateTime;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(Icons.calendar_month))
                      ],
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
                              isSelected: _selectedJobType == "" ? false : true,
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
                              isSelected:
                                  _selectedJobLevel == "" ? false : true,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showJobCategoryModalSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height / 1.8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ModalTopBar(),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferred Job Category",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.5),
                      ),
                      _selectedCategory == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = "";
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue)),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: _categoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory =
                                  _categoryList[index]['categoryName'];
                              _selectedCategoryId =
                                  _categoryList[index]['id'].toString();

                              widget.jobPost.jobCategory = JobCategory(
                                  id: _categoryList[index]['id'],
                                  category: _categoryList[index]
                                      ['categoryName']);
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _categoryList[index]['categoryName'],
                              style: TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEducationCategoryModalSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height / 2,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ModalTopBar(),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Education",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.5),
                      ),
                      _selectedDegree == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedDegree = "";
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue)),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: _degreeNameList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDegree =
                                  _degreeNameList[index]['degreeName'];
                              widget.jobPost.degree =
                                  _degreeNameList[index]['degreeName'];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _degreeNameList[index]['degreeName'],
                              style: TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showJobTypeModalSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height / 1.8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ModalTopBar(),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferred Job Type",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.5),
                      ),
                      _selectedJobType == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedJobType = "";
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue)),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: _jobTypeList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedJobType = _jobTypeList[index]['jobType'];
                              widget.jobPost.jobType = _selectedJobType;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _jobTypeList[index]['jobType'],
                              style: TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showJobLevelModalSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height / 1.8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ModalTopBar(),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferred Job Level",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.5),
                      ),
                      _selectedJobLevel == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedJobLevel = "";
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue)),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: _jobLevelList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedJobLevel =
                                  _jobLevelList[index]['jobLevel'];
                              widget.jobPost.jobLevel = _selectedJobLevel;
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _jobLevelList[index]['jobLevel'],
                              style: TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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
