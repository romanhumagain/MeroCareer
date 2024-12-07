import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_provider.dart';

class HomeScreenHeading extends StatelessWidget {
  const HomeScreenHeading({
    super.key,
    required this.size,
  });

  final Size size;
  String getGreetingMessage() {
    int currentHour = DateTime.now().hour;

    if (currentHour < 12) {
      return "Good Morning";
    } else if (currentHour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 8,
      width: size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Consumer<JobSeekerProvider>(builder: (context, provider, child){
              final jobSeekerData = provider.jobSeekerProfileDetails;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    getGreetingMessage(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  Text(
                    jobSeekerData?['full_name'] ?? "...Loading",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4),
                  ),
                  Text(
                    "Find the perfect jobs that suites your interest !",
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400),
                  )
                ],
              );
            }),

            // Notification Icon
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children:  const [
                  Icon(
                    Icons.notifications_active,
                    size: 25,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
