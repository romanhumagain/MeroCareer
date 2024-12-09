import 'package:flutter/material.dart';

class AboutMeSection extends StatelessWidget {
  final Map<String, dynamic> data;
  final Size size;

  const AboutMeSection({
    super.key,
    required this.size,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final aboutMeText = data['profile_summary'] ?? "N/A";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "About Me",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 20.5, letterSpacing: 0.4),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 26,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // About Me Content
          SizedBox(
            width: size.width,
            child: Text(
              aboutMeText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15.3,
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
