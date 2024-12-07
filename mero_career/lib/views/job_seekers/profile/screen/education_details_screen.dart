import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/my_button.dart';
import '../../../widgets/my_custom_textfield.dart';
import '../../common/modal_top_bar.dart';
import '../widgets/education_details_data.dart';

class EducationDetailsScreen extends StatefulWidget {
  const EducationDetailsScreen({super.key});

  @override
  State<EducationDetailsScreen> createState() => _EducationDetailsScreenState();
}

class _EducationDetailsScreenState extends State<EducationDetailsScreen> {
  final TextEditingController _educationProgramController =
      TextEditingController();
  final TextEditingController _instituteNameController =
      TextEditingController();
  final TextEditingController _startedDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String _selectedDegree = "";

  final List<Map<String, dynamic>> _degreeNameList = [
    {"id": 1, "degreeName": "Doctorate (Ph.D)"},
    {"id": 2, "degreeName": "Graduate (Masters)"},
    {"id": 3, "degreeName": "Under Graduate (Bachelors)"},
    {"id": 4, "degreeName": "Higher Secondary (+2/A levels)"},
    {"id": 5, "degreeName": "Diploma Certificate"},
    {"id": 6, "degreeName": "School (SEE)"},
    {"id": 7, "degreeName": "Other"},
  ];

  bool isCurrentlyStudying = false;
  bool hasEducationData = false;
  bool isLoading = true;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (selectedDate != null) {
      setState(() {
        controller.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void clearEducationDetails() {
    _educationProgramController.clear();
    _instituteNameController.clear();
    _startedDateController.clear();
    _endDateController.clear();
    _selectedDegree = "";
  }

  void _handleEducationDetails() async {
    Map<String, dynamic> educationDetails = {
      'education_program': _educationProgramController.text.trim(),
      'institute_name': _instituteNameController.text.trim(),
      'start_date': _startedDateController.text.trim(),
      'end_date': _endDateController.text.trim(),
      'degree_type': _selectedDegree,
    };
    if (_endDateController.text.trim() == "") {
      educationDetails.remove("end_date");
    }

    final profileSetupProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);
    final response = await profileSetupProvider.addEducationDetails(
        context, educationDetails);
    if (response?.statusCode == 201) {
      clearEducationDetails();
      setState(() {
        hasEducationData = true;
      });
    }
    print(response?.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEducationDetails();
  }

  // void fetchEducationDetails
  void fetchEducationDetails() async {
    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<ProfileSetupProvider>(context, listen: false);
    await provider.fetchEducationDetails();
    setState(() {
      isLoading = false;
      hasEducationData = provider.educationDetails != null &&
          provider.educationDetails!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isLoading) {
      return Scaffold(
        appBar: MyAppBar(),
      );
    }

    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Education",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 21.5),
                  ),
                  hasEducationData
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hasEducationData = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade600,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.add,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "Highlight your education background, including degrees, certificates, to showcase your qualification.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 15,
              ),
              !hasEducationData
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SelectContainer(
                                isSelected:
                                    _selectedDegree == "" ? false : true,
                                selectText: _selectedDegree == ""
                                    ? "Select Degree"
                                    : _selectedDegree,
                                onTap: () {
                                  _showEducationCategoryModalSheet(context);
                                },
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              MyCustomTextfield(
                                  labelText: "Education Program",
                                  controller: _educationProgramController),
                              SizedBox(
                                height: 18,
                              ),
                              MyCustomTextfield(
                                  labelText: "Name of Institute",
                                  controller: _instituteNameController),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Currently Studying?",
                                    style: TextStyle(
                                      fontSize:
                                          16, // Slightly smaller font size.
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.88,
                                    child: Switch(
                                      value: isCurrentlyStudying,
                                      onChanged: (value) {
                                        setState(() {
                                          isCurrentlyStudying = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                      inactiveThumbColor: Colors.grey.shade400,
                                      inactiveTrackColor: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context, _startedDateController);
                                },
                                child: AbsorbPointer(
                                  child: MyCustomTextfield(
                                      labelText: "Start Date",
                                      controller: _startedDateController),
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              !isCurrentlyStudying
                                  ? GestureDetector(
                                      onTap: () {
                                        _selectDate(
                                            context, _endDateController);
                                      },
                                      child: AbsorbPointer(
                                        child: MyCustomTextfield(
                                            labelText: "End Date",
                                            controller: _endDateController),
                                      ),
                                    )
                                  : Text(""),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: MyButton(
                              color: Colors.blue,
                              width: size.width,
                              height: size.height / 18,
                              text: "Save Changes",
                              onTap: () {
                                _handleEducationDetails();
                              }),
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 15,
              ),
              MyDivider(),
              SizedBox(
                height: 8,
              ),
              EducationDetailsData(),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
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
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(12),
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
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
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
