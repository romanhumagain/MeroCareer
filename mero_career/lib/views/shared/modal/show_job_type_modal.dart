// job_type_modal_sheet.dart
import 'package:flutter/material.dart';

import '../../job_seekers/common/modal_top_bar.dart';

class ShowJobTypeModal extends StatelessWidget {
  final String selectedJobType;
  final Function(String) onValueSelected;

  ShowJobTypeModal({
    required this.selectedJobType,
    required this.onValueSelected,
  });

  final List<Map<String, dynamic>> _jobTypeList = [
    {"id": 1, "jobType": "Full Time"},
    {"id": 2, "jobType": "Part Time"},
    {"id": 3, "jobType": "Internship"},
    {"id": 4, "jobType": "Remote"},
    {"id": 5, "jobType": "Freelance"},
    {"id": 6, "jobType": "Traineeship"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: size.height / 1.8,
      decoration: BoxDecoration(
        color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 5),
            ModalTopBar(),
            SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Preferred Job Type",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18.5),
                  ),
                  selectedJobType.isEmpty
                      ? Text("")
                      : GestureDetector(
                          onTap: () {
                            onValueSelected(""); // Reset the selected job type
                            Navigator.pop(context);
                          },
                          child: Text("Clear",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue)),
                        ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: _jobTypeList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onValueSelected(_jobTypeList[index]['jobType']);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          _jobTypeList[index]['jobType'],
                          style: TextStyle(fontSize: 16.4),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
