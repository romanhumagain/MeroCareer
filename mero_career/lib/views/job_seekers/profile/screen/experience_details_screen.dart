import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/widgets/my_custom_textfield.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/profile_setup_provider.dart';
import '../../../widgets/my_button.dart';
import '../widgets/experience_details_data.dart';

class ExperienceDetailsScreen extends StatefulWidget {
  const ExperienceDetailsScreen({super.key});

  @override
  State<ExperienceDetailsScreen> createState() =>
      _ExperienceDetailsScreenState();
}

class _ExperienceDetailsScreenState extends State<ExperienceDetailsScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobRoleController = TextEditingController();
  final TextEditingController _instituteNameController =
      TextEditingController();
  final TextEditingController _startedDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  bool isCurrentlyWorking = false;
  bool hasExperienceData = false;
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

  void _handleAddingExperience() async {
    Map<String, dynamic> jobDetails = {
      'job_title': _jobTitleController.text.trim(),
      'job_role': _jobRoleController.text.trim(),
      'institute_name': _instituteNameController.text.trim(),
      'start_date': _startedDateController.text.trim(),
    };
    if (_endDateController.text.trim() == "") {
      jobDetails.remove("end_date");
    }

    final profileSetupProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);
    final response =
        await profileSetupProvider.addExperienceDetails(context, jobDetails);
    print(response?.body);
    if (response?.statusCode == 201) {
      clearJobDetails();
      setState(() {
        hasExperienceData = true;
      });
    }
  }

  void clearJobDetails() {
    _jobTitleController.clear();
    _jobRoleController.clear();
    _instituteNameController.clear();
    _startedDateController.clear();
    _endDateController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchExperienceDetails();
  }

  void fetchExperienceDetails() async {
    setState(() {
      isLoading = true;
    });
    final provider = Provider.of<ProfileSetupProvider>(context, listen: false);
    await provider.fetchExperienceDetails();
    setState(() {
      isLoading = false;
      hasExperienceData = provider.experienceDetails != null &&
          provider.experienceDetails!.isNotEmpty;
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 21.5),
                  ),
                  hasExperienceData
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hasExperienceData = false;
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
                "Highlight your experience details, including degrees, certificates, to showcase your qualification.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 15,
              ),
              !hasExperienceData
                  ? Column(
                      children: [
                        MyCustomTextfield(
                            labelText: "Job Title",
                            controller: _jobTitleController),
                        SizedBox(
                          height: 15,
                        ),
                        MyCustomTextfield(
                            labelText: "Job Role",
                            controller: _jobRoleController),
                        SizedBox(
                          height: 15,
                        ),
                        MyCustomTextfield(
                            labelText: "Institute Name",
                            controller: _instituteNameController),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Currently Working?",
                              style: TextStyle(
                                fontSize: 16, // Slightly smaller font size.
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.88,
                              child: Switch(
                                value: isCurrentlyWorking,
                                onChanged: (value) {
                                  setState(() {
                                    isCurrentlyWorking = value;
                                  });
                                },
                                activeColor: Colors.blue,
                                // Active thumb color.
                                inactiveThumbColor: Colors.grey.shade400,
                                // Inactive thumb color.
                                inactiveTrackColor: Colors
                                    .grey.shade300, // Inactive track color.
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
                        !isCurrentlyWorking
                            ? GestureDetector(
                                onTap: () {
                                  _selectDate(context, _endDateController);
                                },
                                child: AbsorbPointer(
                                  child: MyCustomTextfield(
                                      labelText: "End Date",
                                      controller: _endDateController),
                                ),
                              )
                            : Text(""),
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
                                _handleAddingExperience();
                              }),
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              MyDivider(),
              ExperienceDetailsData(),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
