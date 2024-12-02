import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class ProjectDetailsData extends StatelessWidget {
  const ProjectDetailsData({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjcetDetailsTimeline(
                projectName: "Blogify",
                projectUrl: "www.blogify.com.np",
                description:
                    "Blogify is a social blogging platform developed with Django and React.",
                role: "Developer",
              ),
              Row(
                children: [
                  Text(
                    'Delete',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blueAccent, fontSize: 17),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.blueAccent, fontSize: 17),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProjcetDetailsTimeline extends StatelessWidget {
  final String projectName;
  final String projectUrl;
  final String description;
  final String role;

  const ProjcetDetailsTimeline({
    super.key,
    required this.projectName,
    required this.projectUrl,
    required this.description,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 2,
                  height: 70,
                  color: Colors.red.shade300,
                ),
              ],
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  projectUrl,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: size.width / 1.99,
                  child: Text(
                    description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
