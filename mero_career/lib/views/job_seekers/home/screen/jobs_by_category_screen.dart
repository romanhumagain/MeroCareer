import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../../models/job/job_category_model.dart';
import '../widgets/category_job_details_card.dart';

class JobsByCategoryScreen extends StatefulWidget {
  final JobCategory category;

  const JobsByCategoryScreen({super.key, required this.category});

  @override
  State<JobsByCategoryScreen> createState() => _JobsByCategoryScreenState();
}

class _JobsByCategoryScreenState extends State<JobsByCategoryScreen> {
  String _listJobsBy = "active";
  final List<String> _filterList = ['active', 'closed'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchJobs();
    });
  }

  void _fetchJobs() {
    Provider.of<JobSeekerJobProvider>(context, listen: false)
        .getJobsByCategory(context, widget.category.id, _listJobsBy);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                      widget.category.category,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontSize: 21.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Latest job vacancy in ${widget.category.category} in Nepal. Click on the job that interests you, and apply on jobs.",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 13.5, color: Colors.grey.shade200),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),

            // Filter Chips Section
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _filterList.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChip(
                      label: Text(
                        filter.toUpperCase(),
                        style: const TextStyle(fontSize: 12.5),
                      ),
                      selected: _listJobsBy == filter,
                      onSelected: (selected) {
                        setState(() {
                          _listJobsBy = selected ? filter : 'active';
                          _fetchJobs();
                        });
                      },
                      selectedColor:
                          _listJobsBy == "active" ? Colors.green : Colors.red,
                      padding: const EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Job List Section
            Consumer<JobSeekerJobProvider>(
              builder: (context, jobProvider, child) {
                final jobList = jobProvider.jobListByCategory;
                if (jobList == null || jobList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: const Text(
                        "No jobs found for this category!",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: jobList.map((job) {
                      return CategoryJobDetailsCard(
                          size: size,
                          cardColor: cardColor,
                          tertiaryColor: tertiaryColor,
                          job: job,
                          categoryId: widget.category.id,
                          filter: _listJobsBy);
                    }).toList(),
                  );
                }
              },
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
