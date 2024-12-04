import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Project Details",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 19, letterSpacing: 0.1),
              ),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 30,
              )
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              children: const [
                ProjcetDetailsTimeline(
                  projectName: "Blogify",
                  projectUrl: "www.blogify.com.np",
                  description:
                      "Blogify is a social blogging platform developed with Django and React",
                  role: "Developer",
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
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
                  height: 60,
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
                    fontSize: 16,
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
                    fontWeight: FontWeight.w500,
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: size.width / 1.5,
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
