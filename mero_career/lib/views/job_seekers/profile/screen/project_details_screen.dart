import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/project_details_data.dart';
import 'package:mero_career/views/widgets/my_profile_text_area.dart';
import 'package:provider/provider.dart';

import '../../../../providers/profile_setup_provider.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_custom_textfield.dart';
import '../../../widgets/my_divider.dart';
import '../../common/app_bar.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({super.key});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final TextEditingController _projectTitleController = TextEditingController();
  final TextEditingController _projectRoleController = TextEditingController();
  final TextEditingController _projectDescriptionController =
      TextEditingController();

  bool hasProjectDone = false;
  bool isLoading = true;

  void _handleProjectSubmission() async {
    Map<String, dynamic> projectDetails = {
      'project_title': _projectTitleController.text.trim(),
      'role': _projectRoleController.text.trim(),
      'project_description': _projectDescriptionController.text.trim(),
    };
    final profileSetupProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);
    final response =
        await profileSetupProvider.addProjectDetails(context, projectDetails);
    if (response?.statusCode == 201) {
      clearProjectDetails();
      setState(() {
        hasProjectDone = true;
      });
    }
    print(response?.body);
  }

  void clearProjectDetails() {
    _projectTitleController.clear();
    _projectRoleController.clear();
    _projectDescriptionController.clear();
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
    await provider.fetchProjectDetails();
    setState(() {
      isLoading = false;
      hasProjectDone = provider.projectDetails != null &&
          provider.projectDetails!.isNotEmpty;
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
                    "Project Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 21.5),
                  ),
                  hasProjectDone
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hasProjectDone = false;
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
                "Highlight your project details, including degrees, certificates, to showcase your qualification.",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 15,
              ),
              !hasProjectDone
                  ? Column(
                      children: [
                        MyCustomTextfield(
                            labelText: "Project Title",
                            controller: _projectTitleController),
                        SizedBox(
                          height: 15,
                        ),
                        MyCustomTextfield(
                            labelText: "Role",
                            controller: _projectRoleController),
                        SizedBox(
                          height: 15,
                        ),
                        MyProfileTextArea(
                            labelText: "Project Description",
                            controller: _projectDescriptionController),
                        SizedBox(
                          height: 15,
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
                                _handleProjectSubmission();
                              }),
                        )
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              MyDivider(),
              ProjectDetailsData(),
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
