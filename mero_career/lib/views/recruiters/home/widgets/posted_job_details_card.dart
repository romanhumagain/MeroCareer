import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../../utils/date_formater.dart';
import '../screen/posted_job_details_screen.dart';

class PostedJobDetailsCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final Size size;
  final Color cardColor;
  final Color tertiaryColor;

  const PostedJobDetailsCard(
      {super.key,
      required this.size,
      required this.tertiaryColor,
      required this.cardColor,
      required this.job});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, top: 8, bottom: 8),
      child: Row(
        children: [
          Material(
            elevation: 1,
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PostedJobDetailsScreen(id: job['id'])));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                width: size.width / 1.12,
                decoration: BoxDecoration(
                    color: cardColor, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                job['recruiter_details']
                                    ['company_profile_image'],
                                height: 40,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job['job_title'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.5,
                                      color: isDarkMode
                                          ? Colors.grey.shade100
                                          : Colors.grey.shade900,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  job['category_name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 13,
                                        color: isDarkMode
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade800,
                                      ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        spacing: 6, // Horizontal spacing between children
                        runSpacing: 8, // Vertical spacing between rows
                        children: [
                          _buildInfoChip(
                              "No. of Vacancy- ", "${job['no_of_vacancy']}"),
                          _buildInfoChip("${job['job_type']}"),
                          _buildInfoChip("${job['job_level']}"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          formatDeadline(job['deadline']),
                          style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade800,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildInfoChip(String label, [String? value]) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.blue.shade300,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Ensures the Row doesn't expand
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        if (value != null) ...[
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ],
    ),
  );
}
