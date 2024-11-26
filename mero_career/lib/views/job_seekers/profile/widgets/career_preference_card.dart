import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/preference_badge.dart';

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
        showCareerPreferenceScreen(context);
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_upward,
                              color: Colors.green.shade100),
                          Text(
                            "Boost 12 %",
                            style: TextStyle(color: Colors.green.shade100),
                          ),
                        ],
                      ),
                    ),
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

  void showCareerPreferenceScreen(BuildContext context) {
    TextEditingController _jobRolesController = TextEditingController();
    TextEditingController _jobLocationController = TextEditingController();
    TextEditingController _jobTypeController = TextEditingController();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: size.height / 1.15,
            width: size.width,
            decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModalTopBar(),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Career Preference",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 21)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Add details about your prefered job profile. This helps us personalise your job recommendations",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: Column(
                            children: [
                              PreferenceTextField(
                                controller: _jobRolesController,
                                labelText: "Prefered Job Roles",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PreferenceTextField(
                                controller: _jobLocationController,
                                labelText: "Prefered Job Location",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PreferenceTextField(
                                controller: _jobRolesController,
                                labelText: "Prefered Job Roles",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PreferenceDropdownButton(
                                items: const [
                                  "Part-Time",
                                  "Full-Time",
                                  "Remote"
                                ],
                                labelText: "Prefered Job Type",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              PreferenceDropdownButton(
                                items: const [
                                  "IT & Telecommunication",
                                  "Banking",
                                  "Education",
                                  "Construction",
                                  "Design"
                                ],
                                labelText: "Prefered Job Category",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
