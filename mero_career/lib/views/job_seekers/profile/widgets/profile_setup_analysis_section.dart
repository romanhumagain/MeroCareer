import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/profile/widgets/profile_recommendation_card.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProfileSetupAnalysisSection extends StatelessWidget {
  const ProfileSetupAnalysisSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      height: size.height / 4,
      width: size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height,
              width: size.width / 2.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircularPercentIndicator(
                    radius: 26.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "20.0%",
                      style: new TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.red,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "MeroCareer experts suggest you to have a complete profile",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "10 Missing details !",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.file_copy,
              heading: "Never miss adding your resume ",
              buttonTitle: "Upload Resume",
              onTap: () {},
            ),
            SizedBox(
              width: 15,
            ),
            ProfileRecommendationCard(
              size: size,
              percentageCover: "10",
              icon: Icons.camera_alt,
              heading: "Profile with photo are more noticeable ",
              buttonTitle: "Upload Photo",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
