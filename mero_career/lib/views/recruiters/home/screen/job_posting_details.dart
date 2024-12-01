import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';

class JobListingsScreen extends StatefulWidget {
  @override
  State<JobListingsScreen> createState() => _JobListingsScreenState();
}

class _JobListingsScreenState extends State<JobListingsScreen> {
  final List<Map<String, String>> jobListings = [
    {"title": "Software Engineer", "status": "Open"},
    {"title": "UI/UX Designer", "status": "Closed"},
    {"title": "Project Manager", "status": "Paused"},
  ];

  String _listJobsBy = "all";
  final List<String> _filterList = ['all', 'open', 'closed', 'archive'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            Expanded(
              child: ListView.builder(
                itemCount: jobListings.length,
                itemBuilder: (context, index) {
                  final job = jobListings[index];
                  final statusColor = _getStatusColor(job["status"]!);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(job["title"]!),
                      subtitle: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              job["status"]!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text("Posted on: 12th Nov, 2024"), // Example metadata
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'view', child: Text("View")),
                          PopupMenuItem(value: 'edit', child: Text("Edit")),
                          PopupMenuItem(
                              value: 'archive', child: Text("Archive")),
                        ],
                        onSelected: (value) {
                          // Handle actions
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Open":
        return Colors.green;
      case "Closed":
        return Colors.red;
      case "Paused":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class LobListingFilterOption extends StatelessWidget {
  const LobListingFilterOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Open",
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
