import 'package:flutter/material.dart';

import '../widget/continue_skip.dart';
import '../widget/experience_details.dart';

class WorkExperienceConfirmation extends StatefulWidget {
  const WorkExperienceConfirmation({super.key});

  @override
  State<WorkExperienceConfirmation> createState() =>
      _WorkExperienceConfirmationState();
}

class _WorkExperienceConfirmationState
    extends State<WorkExperienceConfirmation> {
  bool? _isExperienced; // Nullable bool for initial unselected state

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.width > 400 ? 15.0 : 8.0),
      // Responsive padding
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Do you have any working experience?",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 21),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExperienced = true;
                          });
                        },
                        child: ExperienceConfirmation(
                          isSelected: _isExperienced == true,
                          confirmation: "Yes, I have",
                          confirmationMessage: "I have working experience",
                          avatarImageUrl: 'assets/images/avatar1.png',
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExperienced = false;
                          });
                        },
                        child: ExperienceConfirmation(
                          isSelected: _isExperienced == false,
                          confirmation: "No, I haven't",
                          confirmationMessage:
                              "I have not any working experience",
                          avatarImageUrl: 'assets/images/avatar2.png',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _isExperienced == null
                    ? const Text(
                        "Please select an option.",
                        style: TextStyle(fontSize: 16),
                      )
                    : _isExperienced == true
                        ? const ExperienceDetails()
                        : const Text(
                            "No Experience!",
                            style: TextStyle(fontSize: 16),
                          ),
              ],
            ),
            SizedBox(height: 20),
            _isExperienced == null || _isExperienced == false
                ? SizedBox(
                    height: 250,
                  )
                : SizedBox(
                    height: 5,
                  ),
            ContinueSkip(
              onContinue: () {
                if (_isExperienced == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select an option to continue."),
                    ),
                  );
                } else {
                  // Handle continue logic here
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceConfirmation extends StatelessWidget {
  final String confirmation;
  final String confirmationMessage;
  final String avatarImageUrl;
  final bool isSelected;

  const ExperienceConfirmation({
    super.key,
    required this.confirmation,
    required this.confirmationMessage,
    required this.avatarImageUrl,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected
              ? Colors.blue.shade50
              : Theme.of(context).colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  avatarImageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                confirmation,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 17.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                confirmationMessage,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
