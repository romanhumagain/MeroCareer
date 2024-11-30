import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../job_seekers/home/screen/job_details_screen.dart';

class PostedJobDetailsCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String imageUrl;
  final String deadline;
  final Size size;
  final Color cardColor;
  final Color tertiaryColor;

  const PostedJobDetailsCard({
    super.key,
    required this.size,
    required this.tertiaryColor,
    required this.cardColor,
    required this.jobTitle,
    required this.companyName,
    required this.imageUrl,
    required this.deadline,
  });

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
                        builder: (context) => JobDetailsScreen()));
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
                              child: Image.asset(
                                imageUrl,
                                height: 40,
                                width: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jobTitle,
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
                                  companyName,
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
                        Container(
                          height: 25,
                          width: 25,
                          padding: const EdgeInsets.all(3),
                          // Adjust size
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red.shade100,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(color: Colors.grey.shade700),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Wrap(
                      spacing: 15, // Horizontal spacing between children
                      runSpacing: 8, // Vertical spacing between rows
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.school,
                              color: tertiaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Under Graduate (Bachelor)",
                              style: TextStyle(color: tertiaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.card_giftcard,
                              color: tertiaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Mid Level",
                              style: TextStyle(color: tertiaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.roller_shades_closed_outlined,
                              color: tertiaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Not Disclosed",
                              style: TextStyle(color: tertiaryColor),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: tertiaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Pulchowk, Lalitpur",
                              style: TextStyle(color: tertiaryColor),
                            ),
                          ],
                        ),
                      ],
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
                          "Deadline $deadline minutes from now",
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
