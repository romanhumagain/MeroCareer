import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/widgets/profile/education_details_form.dart';

import '../continue_skip.dart';

class EducationSchoolLevel extends StatelessWidget {
  const EducationSchoolLevel({super.key});

  static const List<String> educationBoard = ["NEB", "HSEB"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EducationDetailsForm(
            educationBoard: educationBoard,
            educationType: "Board",
            educationLevel: "School",
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 30,
                  ),
                  Text(
                    "Add More Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 18.5, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ContinueSkip(onContinue: () {})
            ],
          )
        ],
      ),
    );
  }
}
