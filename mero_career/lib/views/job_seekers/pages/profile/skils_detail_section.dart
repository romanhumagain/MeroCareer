import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/widgets/continue_skip.dart';

class AddSkillsScreen extends StatefulWidget {
  const AddSkillsScreen({super.key});

  @override
  State<AddSkillsScreen> createState() => _AddSkillsScreenState();
}

class _AddSkillsScreenState extends State<AddSkillsScreen> {
  final TextEditingController _skillController = TextEditingController();
  List<String> skills = [];

  void _addSkill() {
    if (_skillController.text.trim().isNotEmpty) {
      setState(() {
        skills.add(_skillController.text.trim());
        _skillController.clear();
      });
    }
  }

  void _removeSkill(String skill) {
    setState(() {
      skills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      "Add the skills you possess:",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _skillController,
                          decoration: InputDecoration(
                            hintText: "Enter a skill (e.g., Design, Python)",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  color: Colors.grey,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _addSkill();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(14)),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.add_circle_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 4.0,
                    children: skills.map((skill) {
                      return Chip(
                        label: Text(
                          skill,
                          style: TextStyle(
                            color: Colors.blue.shade800, // Text color
                            fontWeight:
                                FontWeight.w500, // Make the text slightly bold
                          ),
                        ),
                        backgroundColor: Colors.blue.shade50,
                        // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          // Rounded corners
                          side: BorderSide(
                            color: Colors.blue.shade100, // Border color
                          ),
                        ),
                        deleteIcon: Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.red, // Icon color
                        ),
                        onDeleted: () => _removeSkill(skill),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          ContinueSkip(onContinue: () {})
        ],
      ),
    );
  }
}
