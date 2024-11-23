import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_profile_text_area.dart';

import '../../../widgets/my_profile_textfield.dart';

class ProjectDetailsForm extends StatefulWidget {
  const ProjectDetailsForm({super.key});

  @override
  State<ProjectDetailsForm> createState() => _ProjectDetailsFormState();
}

class _ProjectDetailsFormState extends State<ProjectDetailsForm> {
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _projectURL = TextEditingController();
  final TextEditingController _projectDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add project details",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontSize: 19.5, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 15),
        Text(
          "Project Name",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        MyProfileTextfield(
          labelText: "",
          hintText: "eg: MeroCareer",
          prefixIcon: Icons.dataset_sharp,
          verticalContentPadding: 12,
          controller: _projectNameController,
        ),
        SizedBox(height: 20),
        Text(
          "Your Role",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        MyProfileTextfield(
          labelText: "",
          hintText: "eg: developer",
          prefixIcon: Icons.dataset_sharp,
          verticalContentPadding: 12,
          controller: _roleController,
        ),
        SizedBox(height: 20),
        Text(
          "Project URL (Optional)",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        MyProfileTextfield(
          labelText: "",
          hintText: "eg: https://roman.com.np/",
          prefixIcon: Icons.dataset_sharp,
          verticalContentPadding: 12,
          controller: _projectURL,
        ),
        SizedBox(height: 20),
        Text(
          "Project Description",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 8),
        MyProfileTextArea(
          labelText: "",
          hintText: "Write about your project here",
          controller: _projectDescription,
        ),
      ],
    );
  }
}
