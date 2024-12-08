import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../../common/app_bar.dart';
import '../widgets/job_details_card.dart';

class AllJobs extends StatefulWidget {
  const AllJobs({super.key});

  @override
  State<AllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAllJob();
    });
  }

  void _fetchAllJob() async {
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .fetchAllActiveJobs();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height / 8,
                decoration: BoxDecoration(
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
                        "All Active Jobs for You 🚀",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 22, color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Discover handpicked opportunities from leading companies. Take the next step in your career!",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 14.5, color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                'assets/images/job_details/jobs_illustration.png',
                height: 230,
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Consumer<JobSeekerJobProvider>(
                    builder: (context, provider, child) {
                  final allActiveJobLists = provider.allActiveJobs;
                  final isLoading = provider.isLoading;
                  if (isLoading) {
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (allActiveJobLists!.isEmpty) {
                    return Center(
                      child: Text("No any active jobs found ! "),
                    );
                  }
                  return Column(
                    children: allActiveJobLists.map((job) {
                      return JobDetailsCard(
                        size: size,
                        cardColor: cardColor,
                        tertiaryColor: tertiaryColor,
                        job: job,
                      );
                    }).toList(),
                  );
                }),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
