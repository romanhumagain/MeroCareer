import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/recruiters/home/screen/posted_job_details_screen.dart';
import 'package:mero_career/views/recruiters/job_post/screen/edit_job_post.dart';
import 'package:mero_career/views/widgets/custom_confirmation_message.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';
import '../../../../services/auth_services.dart';
import '../../../../utils/date_formater.dart';

class JobListingsScreen extends StatefulWidget {
  const JobListingsScreen({super.key});

  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  late Future<List<dynamic>?> jobLists;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<JobProvider>(context, listen: false)
        .getFilterableJobPosts(filter_by: _listJobsBy);
  }

  Future<List<dynamic>?> _fetchJobLists() async {
    final response = await Provider.of<JobProvider>(context, listen: false)
        .getFilterableJobPosts(filter_by: _listJobsBy);
    if (response?.statusCode == 401) {
      AuthServices authServices = AuthServices();
      authServices.logoutUser();
      return null;
    }
    return response?.statusCode == 200 ? json.decode(response!.body) : null;
  }

  String _listJobsBy = "all";
  final List<String> _filterList = ['all', 'active', 'closed'];

  void handleDelete(BuildContext context, int id) async {
    bool isConfirmed = await showCustomConfirmationDialog(context,
        "Are you sure you want to delete this job post? This action cannot be undone.");
    if (isConfirmed) {
      final response = await Provider.of<JobProvider>(context, listen: false)
          .deleteJobPost(id);
      print(response?.body);
      if (response?.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully deleted job post.",
            type: MessageType.success);
      } else if (response?.statusCode == 401) {
        AuthServices authServices = AuthServices();
        authServices.logoutUser();
      } else {
        print(response?.statusCode);
        showCustomFlushbar(
            context: context,
            message: "Sorry, couldn't deleted job post.",
            type: MessageType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Your Job Listing",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 21.5),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 28,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: _filterList.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChip(
                      label: Text(
                        filter.toUpperCase(),
                        style: TextStyle(fontSize: 12.5),
                      ),
                      selected: _listJobsBy == filter,
                      onSelected: (selected) {
                        setState(() {
                          _listJobsBy = selected ? filter : 'all';
                          jobLists = _fetchJobLists();
                        });
                      },
                      selectedColor: Colors.blueAccent,
                      padding: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  );
                }).toList(),
              ),
              Divider(
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<JobProvider>(builder: (context, jobProvider, child) {
                final jobLists = jobProvider.filterableJobLists;
                if (jobLists!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No Job Posts Found!",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Start by creating your first job post\nto attract potential candidates.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Column(
                  children: jobLists.map((job) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        title: Text(
                          job["job_title"]!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontSize: 17.5, letterSpacing: 0),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  spacing: 6,
                                  // Horizontal spacing between children
                                  runSpacing: 8,
                                  // Vertical spacing between rows
                                  children: [
                                    _buildInfoChip(job['job_type']),
                                    _buildInfoChip(job['job_level']),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: job['is_active']
                                          ? Colors.green
                                          : Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      job["is_active"] ? "Active" : "Closed",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "Posted on: ${formatPostedDate(job['deadline'])}"),
                                  // Example metadata
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 'view', child: Text("View")),
                            PopupMenuItem(value: 'edit', child: Text("Edit")),
                            PopupMenuItem(
                                value: 'delete', child: Text("Delete")),
                          ],
                          onSelected: (value) {
                            if (value == "view") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PostedJobDetailsScreen(
                                              id: job['id'])));
                            } else if (value == "delete") {
                              handleDelete(context, job['id']);
                            } else if (value == "edit") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditJobPost(id: job['id'])));
                            }
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
    decoration: BoxDecoration(
        // color: Colors.blue.shade300,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey)),
    child: Row(
      mainAxisSize: MainAxisSize.min, // Ensures the Row doesn't expand
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    ),
  );
}
