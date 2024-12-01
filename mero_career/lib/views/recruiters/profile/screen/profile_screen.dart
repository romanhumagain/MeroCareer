import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/recruiters/profile/widgets/about_company_details.dart';
import 'package:mero_career/views/recruiters/profile/widgets/company_basic_details.dart';
import 'package:provider/provider.dart';

class RecruiterProfileScreen extends StatelessWidget {
  const RecruiterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          // profile heading
          CompanyProfileHeadingSection(isDarkMode: isDarkMode),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          SizedBox(
            height: 5,
          ),
          CompanyBasicDetails(size: size),
          SizedBox(
            height: 10,
          ),
          AboutCompanyDetails(size: size),
          SizedBox(
            height: 20,
          ),
          MotivationalMessage(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class CompanyProfileHeadingSection extends StatelessWidget {
  const CompanyProfileHeadingSection({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/company_logo/f1.jpg'),
            radius: 30,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "F1soft International Pvt.Ltd",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            "Software Company",
            style:
                Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 15),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade600,
              ),
              Text("Kathmandu",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 15,
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade600))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          KeyMetricsCards(),
        ],
      ),
    );
  }
}

class KeyMetricsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final metrics = [
      {"title": "Jobs Posted", "value": "45"},
      {"title": "Applicants Received", "value": "1024"},
      {"title": "Hires Made", "value": "18"},
      // {"title": "Top Position", "value": "Software Engineer"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: metrics.map((metric) {
          return Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      metric["value"]!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue),
                    ),
                    SizedBox(height: 8),
                    Text(
                      metric["title"]!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class MotivationalMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 1.1,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.blue.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 40,
            color: Colors.blue.shade700,
          ),
          const SizedBox(height: 16),
          Text(
            "Empowering companies to build great teams.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade800,
                fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            "Your ideal candidate is just a click away.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blueGrey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}
