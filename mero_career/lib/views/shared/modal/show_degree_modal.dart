// category_modal_sheet.dart
import 'package:flutter/material.dart';

import '../../job_seekers/common/modal_top_bar.dart';

class ShowDegreeModal extends StatelessWidget {
  final String title;
  final String selectedValue;
  final Function(String) onValueSelected;

  ShowDegreeModal({
    required this.title,
    required this.selectedValue,
    required this.onValueSelected,
  });

  final List<Map<String, dynamic>> _degreeNameList = [
    {"id": 1, "degreeName": "Doctorate (Ph.D)"},
    {"id": 2, "degreeName": "Graduate (Masters)"},
    {"id": 3, "degreeName": "Under Graduate (Bachelors)"},
    {"id": 4, "degreeName": "Higher Secondary (+2/A levels)"},
    {"id": 5, "degreeName": "Diploma Certificate"},
    {"id": 6, "degreeName": "School (SEE)"},
    {"id": 7, "degreeName": "Other"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: size.height / 2,
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18.5),
                  ),
                  selectedValue.isEmpty
                      ? Text("")
                      : GestureDetector(
                          onTap: () {
                            onValueSelected(""); // Reset selected value
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
                  itemCount: _degreeNameList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onValueSelected(_degreeNameList[index]['degreeName']);
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
                          _degreeNameList[index]['degreeName'],
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
