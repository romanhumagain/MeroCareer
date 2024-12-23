import 'package:flutter/material.dart';
import 'package:mero_career/utils/date_formater.dart';
import 'package:mero_career/views/job_seekers/home/screen/job_details_screen.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../../../../providers/theme_provider.dart';

class AppliedPostDetails extends StatelessWidget {
  final Map<String, dynamic> appliedJob;
  final Size size;
  String filterStatusBy;

  AppliedPostDetails(
      {super.key,
      required this.size,
      required this.appliedJob,
      required this.filterStatusBy});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    final job = appliedJob['job_details'];
    final appliedAt = appliedJob['applied_on'];

    void handleSave(Map<String, dynamic> jobData) async {
      final response =
          await Provider.of<JobSeekerJobProvider>(context, listen: false)
              .saveJob(context, jobData);

      if (response?.statusCode == 201) {
        await Provider.of<JobSeekerJobProvider>(context, listen: false)
            .getAppliedJobs(filterStatusBy);
      }
    }

    void handleUnsave() async {
      final response =
          await Provider.of<JobSeekerJobProvider>(context, listen: false)
              .unSaveJob(context, job['id']);

      if (response?.statusCode == 204) {
        await Provider.of<JobSeekerJobProvider>(context, listen: false)
            .getAppliedJobs(filterStatusBy);
      }
    }

    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 25),
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
                                      fontSize: 18.6,
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
                                        fontSize: 14.5,
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
                                    handleUnsave();
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
                      height: 2,
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
                              color: job['is_active']
                                  ? (isDarkMode
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade800)
                                  : Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 15.4),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          "Applied ${formatSavedAt(appliedAt)}",
                          style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade600,
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
