import 'package:flutter/material.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/screen/job_seeker_profile_preview.dart';

import '../../../../utils/date_formater.dart';

class ApplicantsDetails extends StatelessWidget {
  const ApplicantsDetails({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, top: 5, bottom: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobSeekerProfilePreview(
                            jobSeekerId: data['applicant_details']['id'],
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width / 1.155,
              height: size.height / 5.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/pp.jpg',
                              height: 45,
                              width: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['applicant_details']['full_name'],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                data['applicant_details']['profile_headline'] ??
                                    "N/A",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          data['status'],
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Applied for",
                            style: Theme.of(context).textTheme.labelMedium),
                        Text(
                          data['job_title'],
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 15.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Applied on :- ",
                          style: Theme.of(context).textTheme.labelMedium),
                      Text(
                        formatPostedDate(data['applied_on']),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
