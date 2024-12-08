import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_job_provider.dart';
import '../../home/widgets/job_details_card.dart';
import '../widgets/saved_job_post.dart';

class SavedPostScreen extends StatefulWidget {
  const SavedPostScreen({super.key});

  @override
  State<SavedPostScreen> createState() => _SavedPostScreenState();
}

class _SavedPostScreenState extends State<SavedPostScreen> {
  String _listJobsBy = "active";
  final List<String> _filterList = ['active', 'closed'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getSavedPosts();
    });
  }

  void _getSavedPosts() async {
    bool includeClosedPosts = _listJobsBy == "closed";
    await Provider.of<JobSeekerJobProvider>(context, listen: false)
        .getSavedPosts(includeClosedPosts);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardColor = Theme.of(context).colorScheme.surface;
    final tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Saved Post",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 23),
                ),
                Row(
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
                          if (selected) {
                            setState(() {
                              _listJobsBy = filter;
                            });
                            _getSavedPosts();
                          }
                        },
                        selectedColor:
                            filter == "active" ? Colors.green : Colors.red,
                        padding: const EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const MyDivider(),
            const SizedBox(height: 6),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Consumer<JobSeekerJobProvider>(
                        builder: (context, provider, child) {
                          final savedPosts = provider.savedPosts;
                          if (savedPosts == null || savedPosts.isEmpty) {
                            return const Center(
                              child: Text(
                                "No saved jobs found!",
                                style: TextStyle(
                                    fontSize: 18.5, letterSpacing: 0.2),
                              ),
                            );
                          }
                          return Column(
                            children: savedPosts.map((job) {
                              return SavedJobPostDetails(
                                size: size,
                                savedJob: job,
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
