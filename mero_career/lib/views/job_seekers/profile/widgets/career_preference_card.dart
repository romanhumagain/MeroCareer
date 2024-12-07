import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/views/job_seekers/profile/screen/career_preference_screen.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/preference_badge.dart';
import 'package:provider/provider.dart';

class CareerPreferenceCard extends StatelessWidget {
  const CareerPreferenceCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CareerPreferenceScreen()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        width: size.width / 1.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.blue.shade100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Career Preference",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.4),
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    Consumer<JobSeekerProvider>(builder: (context, provider, child){
                      final jobSeekerDetails = provider.careerPreference;
                      final isAllPrefAdded = jobSeekerDetails?['is_all_pref_added'] ?? false;

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: isAllPrefAdded ? Colors.blue.shade300 :Colors.green.shade200,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            isAllPrefAdded ?
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "View Details",
                                style: TextStyle(color: Colors.green.shade100, fontWeight: FontWeight.w500),
                              ),
                            ):
                            Row(
                              children: [
                                Icon(Icons.arrow_upward,
                                    color: Colors.green.shade100),Text(
                                  "Boost 12 %",
                                  style: TextStyle(color: Colors.green.shade100),
                                ),
                              ],
                            ),

                          ],
                        ),
                      );
                    })

                  ],
                ),
                Icon(
                  Icons.shield,
                  color: Colors.yellow.shade300,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add details about your preferred job profile. This helps us personalize your job recommendation",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    PreferenceBadge(
                      size: size,
                      title: "Location",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    PreferenceBadge(
                      size: size,
                      title: "Role",
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    PreferenceBadge(
                      size: size,
                      title: "Job Type",
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PreferenceDropdownButton extends StatelessWidget {
  final List<String> items;
  final String labelText;

  const PreferenceDropdownButton(
      {super.key, required this.items, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(16),
      icon: Icon(Icons.keyboard_arrow_down),
      items: items
          .map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              ))
          .toList(),
      onChanged: (value) {},
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          labelText: labelText),
    );
  }
}

class PreferenceTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const PreferenceTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        labelText: "$labelText *",
        labelStyle: const TextStyle(
          fontSize: 15,
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}
