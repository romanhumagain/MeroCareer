import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/profile_setup/widget/continue_skip.dart';

class AreaOfInterest extends StatefulWidget {
  const AreaOfInterest({super.key});

  @override
  State<AreaOfInterest> createState() => _AreaOfInterestState();
}

class _AreaOfInterestState extends State<AreaOfInterest> {
  final List<String> interests = [
    "Technology",
    "Healthcare",
    "Arts",
    "Education",
    "Business",
    "Sports",
    "Science",
    "Travel",
    "Music",
    "Cooking",
    "Others",
  ];

  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What is your area of interest?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Let us know your interests so we can personalize your experience.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10.0,
                runSpacing: 12.0,
                children: interests.map((interest) {
                  final isSelected = selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () => toggleInterest(interest),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isSelected ? Colors.blue : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color:
                                isSelected ? Colors.blue : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            interest,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Colors.blue.shade700
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
          ContinueSkip(onContinue: () {})
        ],
      ),
    );
  }
}
