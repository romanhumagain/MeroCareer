import 'package:flutter/material.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:mero_career/views/job_seekers/home/screen/job_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../../../../providers/theme_provider.dart';

class JobDetailsCard extends StatelessWidget {
  final Map<String, dynamic> job;
  final Size size;
  final Color cardColor;
  final Color tertiaryColor;

  const JobDetailsCard(
      {super.key,
      required this.size,
      required this.tertiaryColor,
      required this.cardColor,
      required this.job});

  @override
  Widget build(BuildContext context) {
    void handleSave(Map<String, dynamic> jobData) async {
      await Provider.of<JobSeekerJobProvider>(context, listen: false)
          .saveJob(context, jobData);
    }

    void handleUnsave(int jobId) async {
      await Provider.of<JobSeekerJobProvider>(context, listen: false)
          .unSaveJob(context, jobId);
    }

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JobDetailsScreen(
                              jobTitle: job['job_title'],
                              jobId: job['id'],
                            )));
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
                              child: job['recruiter_details']
                                          ['company_profile_image'] !=
                                      null
                                  ? Image.network(
                                      job['recruiter_details']
                                          ['company_profile_image'],
                                      height: 40,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/company_logo/default_company_pic.png',
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
                                  job['job_title'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: isDarkMode
                                          ? Colors.grey.shade100
                                          : Colors.grey.shade900,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  job['recruiter_details']['company_name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontSize: 14,
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
                        SizedBox(
                          child: job['is_saved']
                              ? GestureDetector(
                                  onTap: () {
                                    handleUnsave(job['id']);
                                  },
                                  child: Icon(
                                    Icons.bookmark,
                                    size: 28,
                                    color: Colors.blue,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    handleSave({'job': job['id']});
                                  },
                                  child: Icon(
                                    Icons.bookmark_border,
                                    size: 28,
                                  ),
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    Wrap(
                      spacing: 15,
                      runSpacing: 8,
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
                              job['degree'],
                              style:
                                  TextStyle(color: tertiaryColor, fontSize: 15),
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
                              job['job_level'],
                              style:
                                  TextStyle(color: tertiaryColor, fontSize: 15),
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
                              job['salary_range'] != null
                                  ? "${job['salary_range']}k/month"
                                  : "Not Disclosed",
                              style:
                                  TextStyle(color: tertiaryColor, fontSize: 15),
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
                              job['recruiter_details']['address'],
                              style:
                                  TextStyle(color: tertiaryColor, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
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
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
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
