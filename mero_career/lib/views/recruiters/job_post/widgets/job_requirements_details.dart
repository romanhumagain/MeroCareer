import 'package:flutter/material.dart';

import '../../../../models/job/job_post_model.dart';

class JobRequirementsDetails extends StatefulWidget {
  final JobPost jobPost;
  final GlobalKey<FormState> formKey;

  const JobRequirementsDetails(
      {super.key, required this.jobPost, required this.formKey});

  @override
  _JobRequirementsDetailsState createState() => _JobRequirementsDetailsState();
}

class _JobRequirementsDetailsState extends State<JobRequirementsDetails> {
  // Create a TextEditingController to control the TextFormField
  final TextEditingController _jobRequirementsController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _jobRequirementsController.text = widget.jobPost.jobRequirements;
  }

  @override
  void dispose() {
    _jobRequirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page Title
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Add Job Requirements",
                style: TextStyle(fontSize: 20.5, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                "Please provide detailed job requirements to help candidates understand the role better.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Divider(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),

        // Job Requirements TextArea
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: widget.formKey,
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
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                // Set hint text color to grey
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  // Rounded corners when focused
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  widget.jobPost.jobRequirements = value;
                });
              },
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
