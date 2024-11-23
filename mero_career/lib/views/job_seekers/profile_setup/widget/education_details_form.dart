import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_profile_textfield.dart';

class EducationDetailsForm extends StatefulWidget {
  final String educationType;
  final String educationLevel;
  final List<String> educationBoard;

  const EducationDetailsForm(
      {super.key,
      required this.educationType,
      required this.educationLevel,
      required this.educationBoard});

  @override
  State<EducationDetailsForm> createState() => _EducationDetailsFormState();
}

class _EducationDetailsFormState extends State<EducationDetailsForm> {
  String? selectedBoard;

  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _completionYearController =
      TextEditingController();
  final TextEditingController _gradeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Column(
        children: [
          Material(
            elevation: 1.5,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).colorScheme.surface,
              ),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      Text(
                        ' Select ${widget.educationType}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                letterSpacing: 0.4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8, left: 20, right: 8),
                    child: DropdownButtonFormField<String>(
                      value: selectedBoard,
                      hint: Text('Choose your ${widget.educationType}"'),
                      items: widget.educationBoard.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBoard = newValue; // Update selected value
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      Text(
                        "Enter Details",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                letterSpacing: 0.4),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4, left: 20, right: 8),
                    child: Column(
                      children: [
                        SizedBox(height: 14),
                        MyProfileTextfield(
                            labelText: "${widget.educationLevel} Name",
                            prefixIcon: Icons.school,
                            verticalContentPadding: 13,
                            controller: _schoolNameController),
                        SizedBox(height: 18),
                        MyProfileTextfield(
                            labelText: "Completion Year",
                            prefixIcon: Icons.date_range,
                            verticalContentPadding: 13,
                            controller: _schoolNameController),
                        SizedBox(height: 18),
                        MyProfileTextfield(
                            labelText: "Grade Optained",
                            prefixIcon: Icons.school,
                            verticalContentPadding: 13,
                            controller: _schoolNameController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
