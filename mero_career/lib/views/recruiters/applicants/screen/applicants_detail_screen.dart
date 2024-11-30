import 'package:flutter/material.dart';
import 'package:mero_career/views/recruiters/home/screen/home_screen.dart';

class ApplicantsDetailScreen extends StatelessWidget {
  final String jobName;

  const ApplicantsDetailScreen({super.key, required this.jobName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        toolbarHeight: 65,
        title: Text(jobName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: Container(
                width: size.width,
                height: size.height / 6.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade500,
                      Colors.blue.shade200,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Review and Connect with Top Talent",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Your next great hire could be among these applicants. Take the first step today!",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14, color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ApplicantsDetails(size: size),
                  ApplicantsDetails(size: size),
                  ApplicantsDetails(size: size),
                  ApplicantsDetails(size: size),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
