import 'package:flutter/material.dart';

import './education_details_form.dart';
import 'continue_skip.dart';

class EducationHigherLevel extends StatelessWidget {
  const EducationHigherLevel({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> eduBoard = ["TU", "PU", "KU", "Foreign University"];
    return SingleChildScrollView(
      child: Column(
        children: [
          EducationDetailsForm(
            educationBoard: eduBoard,
            educationLevel: "University/ College",
            educationType: "University",
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
