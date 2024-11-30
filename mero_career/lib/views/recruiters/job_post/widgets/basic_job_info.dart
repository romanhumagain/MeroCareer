import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/widgets/custom_number_field.dart';
import 'package:mero_career/views/widgets/custom_textfield.dart';

class BasicJobInfo extends StatefulWidget {
  const BasicJobInfo({super.key});

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

  final List<Map<String, dynamic>> _educationList = [
    {"id": 1, "educationName": "Doctorate (Ph.D)"},
    {"id": 2, "educationName": "Graduate (Masters)"},
    {"id": 3, "educationName": "Under Graduate (Bachelors)"},
    {"id": 4, "educationName": "Higher Secondary (+2/A levels)"},
    {"id": 5, "educationName": "Diploma Certificate"},
    {"id": 6, "educationName": "School (SEE)"},
    {"id": 7, "educationName": "Other"},
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
  String _selectedEducation = "";
  String _selectedJobType = "";
  String _selectedJobLevel = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
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
            child: Column(
              children: [
                CustomTextField(
                    controller: _jobTitleController, labelText: "Job Title"),
                SizedBox(
                  height: 10,
                ),
                CustomNumberField(
                    controller: _noOfVacancyController,
                    labelText: "No of Vacancy"),
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
                          isSelected: _selectedCategory == "" ? false : true,
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
                          isSelected: _selectedEducation == "" ? false : true,
                          selectText: _selectedEducation == ""
                              ? "Select Education"
                              : _selectedEducation,
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
                      child: CustomNumberField(
                          controller: _deadlineController,
                          labelText: "Application Deadline"),
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
                          isSelected: _selectedJobLevel == "" ? false : true,
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
          )
        ],
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
                      _selectedEducation == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEducation = "";
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
                      itemCount: _educationList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEducation =
                                  _educationList[index]['educationName'];
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white : Colors.white,
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
                              _educationList[index]['educationName'],
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
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white : Colors.white,
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
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.white : Colors.white,
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
