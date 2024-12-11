import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../job_seekers/common/app_bar.dart';

class ResumePreviewScreen extends StatelessWidget {
  final Map<String, dynamic>? resumeDetails;

  const ResumePreviewScreen({super.key, required this.resumeDetails});

  String formatDate(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy, hh:mm a').format(date);
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    print("http://10.0.2.2:8000${resumeDetails!['resume_file']}");
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: resumeDetails == null
            ? Center(
                child: Text(
                  "No resume available for this job seeker.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Resume Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.file_present, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        "Resume File:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final url =
                                "http://10.0.2.2:8000/${resumeDetails!['resume_file']}";
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Unable to open resume"),
                                ),
                              );
                            }
                          },
                          child: Row(
                            children: const [
                              Text(
                                "Download",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.download_for_offline,
                                color: Colors.blue,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(
                        "Last Updated:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        formatDate(resumeDetails!['updated_at']),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.new_releases, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        "Recently Updated:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        resumeDetails!['is_updated_recently'] ? "Yes" : "No",
                        style: TextStyle(
                          fontSize: 16,
                          color: resumeDetails!['is_updated_recently']
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: resumeDetails!['resume_file'] != null
                        ? SfPdfViewer.network(
                            "http://10.0.2.2:8000${resumeDetails!['resume_file']}",
                          )
                        : Center(
                            child: Text(
                              "No resume file available.",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
