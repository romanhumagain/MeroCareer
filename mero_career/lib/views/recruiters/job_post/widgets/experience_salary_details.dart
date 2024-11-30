import 'package:flutter/material.dart';

class ExperienceSalaryDetails extends StatelessWidget {
  const ExperienceSalaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
          DropdownButtonFormField<int>(
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
            items: [1, 2, 3, 4, 5, 6, 7, 8]
                .map((exp) => DropdownMenuItem<int>(
                      value: exp,
                      child: Text('$exp years'),
                    ))
                .toList(),
            onChanged: (value) {
              // Handle experience selection change
              print("Selected Experience: $value years");
            },
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

              // Optional: You can also add a slider for salary range, if needed
            ],
          ),
        ],
      ),
    );
  }
}
