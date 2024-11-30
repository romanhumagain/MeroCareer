import 'package:flutter/material.dart';

class RecommendationsTipsWidget extends StatelessWidget {
  final List<String> recommendations;

  const RecommendationsTipsWidget({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Recommendations & Tips",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              "Improve your hiring process and job postings with these tips.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 16),

            // Recommendations List
            ...recommendations
                .map((tip) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline,
                              color: Colors.blue.shade400, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              tip,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),

            const SizedBox(height: 16),

            // Explore More Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  // Add navigation to detailed articles or tips page
                },
                icon: const Icon(Icons.article_outlined),
                label: const Text("Explore More"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
