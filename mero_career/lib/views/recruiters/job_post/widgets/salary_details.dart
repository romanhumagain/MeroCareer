import 'package:flutter/material.dart';

class SalaryDetails extends StatelessWidget {
  const SalaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),

          // Heading
          Text(
            "Salary Range (Optional)",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }
}
