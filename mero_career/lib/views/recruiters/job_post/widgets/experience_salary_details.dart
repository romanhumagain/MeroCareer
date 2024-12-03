import 'package:flutter/material.dart';

import '../../../../models/job/job_post_model.dart';

class ExperienceSalaryDetails extends StatefulWidget {
  final JobPost jobPost;
  final GlobalKey<FormState> formKey;

  const ExperienceSalaryDetails(
      {super.key, required this.jobPost, required this.formKey});

  @override
  State<ExperienceSalaryDetails> createState() =>
      _ExperienceSalaryDetailsState();
}

class _ExperienceSalaryDetailsState extends State<ExperienceSalaryDetails> {
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.jobPost.salaryRange.isNotEmpty) {
      List<String> salaryRange = widget.jobPost.salaryRange.split('-');
      if (salaryRange.length == 2) {
        _minSalaryController.text = salaryRange[0].trim();
        _maxSalaryController.text = salaryRange[1].trim();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    void updateSalary() {
      String minSalary = _minSalaryController.text.trim();
      String maxSalary = _maxSalaryController.text.trim();

      if (minSalary.isNotEmpty && maxSalary.isNotEmpty) {
        widget.jobPost.salaryRange = "$minSalary-$maxSalary";
      } else {
        widget.jobPost.salaryRange = "";
      }
    }

    // Update the salary whenever either the min or max salary is changed
    _minSalaryController.addListener(() {
      updateSalary();
    });

    _maxSalaryController.addListener(() {
      updateSalary();
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
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
                ?.copyWith(fontSize: 19.5, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4),

          // Subheading
          Text(
            "Please select the minimum years of experience required for this role.",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 16),

          // Experience Level Dropdown
          Form(
            key: widget.formKey,
            child: DropdownButtonFormField<int>(
              value: widget.jobPost.experience,
              validator: (value) {
                if (value == null) {
                  return 'Please Select Experience';
                }
                return null;
              },
              dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
              decoration: InputDecoration(
                labelText: 'Select Required Experience (in years)',
                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      letterSpacing: 0.5,
                      color: isDarkMode
                          ? Colors.grey.shade500
                          : Colors.grey.shade700,
                    ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              items: [0, 1, 2, 3, 4, 5, 6, 7, 8]
                  .map((exp) => DropdownMenuItem<int>(
                        value: exp,
                        child: Text('$exp years'),
                      ))
                  .toList(),
              onChanged: (value) {
                widget.jobPost.experience = value!;
              },
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          SizedBox(
            height: 14,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),

              // Heading
              Text(
                "Salary Range (Optional)",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 19.5, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),

              // Subheading
              Text(
                "Enter the salary range for this job position. This is optional.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minSalaryController,
                      decoration: InputDecoration(
                        labelText: 'Min Salary',
                        labelStyle:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  color: isDarkMode
                                      ? Colors.grey.shade500
                                      : Colors.grey.shade700,
                                ),
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 10),
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
                        labelStyle:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  color: isDarkMode
                                      ? Colors.grey.shade500
                                      : Colors.grey.shade700,
                                ),
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
