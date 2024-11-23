import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_profile_textfield.dart';

class ExperienceDetails extends StatefulWidget {
  const ExperienceDetails({super.key});

  @override
  State<ExperienceDetails> createState() => _ExperienceDetailsState();
}

class _ExperienceDetailsState extends State<ExperienceDetails> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final List<String> employmentTypes = [
    "Full-time",
    "Part-time",
    "Internship",
    "Contract"
  ];
  String? selectedEmploymentType;

  // Method to show date picker and update controller
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.toLocal()}".split(' ')[0]; // Format to yyyy-MM-dd
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Add Experience Details ",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 19),
          ),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          // Job Title
          Text(
            "Job Title",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          MyProfileTextfield(
            labelText: "",
            hintText: "e.g., Software Engineer",
            prefixIcon: Icons.work,
            verticalContentPadding: 12,
            controller: _jobTitleController,
          ),
          SizedBox(height: 20),

          // Company Name
          Text(
            "Company Name",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          MyProfileTextfield(
            labelText: "",
            hintText: "e.g., ABC Tech Pvt. Ltd.",
            prefixIcon: Icons.business,
            verticalContentPadding: 12,
            controller: _companyNameController,
          ),
          SizedBox(height: 20),

          // Employment Type
          Text(
            "Employment Type",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            hint: Text(
              "Select Employment Type",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            value: selectedEmploymentType,
            items: employmentTypes
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedEmploymentType = value;
              });
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color:
                      isDarkMode ? Colors.grey.shade700 : Colors.grey.shade500,
                ),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
          SizedBox(height: 20),
          // Start Date
          Text(
            "Start Date",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),

          // Start Date Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _startDateController,
                  readOnly: true, // Prevent manual editing
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade500,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.5, horizontal: 25.0),
                    hintText: "Select Start Date",
                    hintStyle:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.grey,
                            ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, _startDateController),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Text(
            "End Date",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 5),

          // End Date Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _endDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade500,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.5, horizontal: 25.0),
                    hintText: "Select End Date",
                    hintStyle:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.grey,
                            ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, _endDateController),
              ),
            ],
          ),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 30,
              ),
              Text(
                "Add More Experience ",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 18.5, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
