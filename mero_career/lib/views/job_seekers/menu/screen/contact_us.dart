import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: const Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Get in Touch",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 24.5)),
            const SizedBox(height: 25),
            ContactRow(
              icon: Icons.phone,
              title: "Phone",
              content: "+977 234 567 890",
            ),
            const SizedBox(height: 18),
            ContactRow(
              icon: Icons.email,
              title: "Email",
              content: "support@merocareer.com",
            ),
            const SizedBox(height: 18),
            ContactRow(
              icon: Icons.location_on,
              title: "Address",
              content: "Lalitpur, Kupondole",
            ),
            const SizedBox(height: 18),
            ContactRow(
              icon: Icons.language,
              title: "Website",
              content: "www.merocareer.com",
            ),
            const Spacer(),
            Center(
              child: Text(
                "We’re here to help! Reach out to us anytime.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const ContactRow({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 26,
          color: Colors.blue,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
