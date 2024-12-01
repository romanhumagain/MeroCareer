import 'package:flutter/material.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class AboutCompanyDetails extends StatefulWidget {
  const AboutCompanyDetails({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AboutCompanyDetails> createState() => _AboutCompanyDetailsState();
}

class _AboutCompanyDetailsState extends State<AboutCompanyDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;

    return GestureDetector(
      onTap: () {
        _showAddCompanyDetailsModal(context);
      },
      child: Container(
        width: widget.size.width / 1.15,
        height: widget.size.height / 5.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About F1soft Pvt.Ltd",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 17.2),
                ),
                Text(
                  "Add",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Highlight your company’s achievements and values to attract top talent.",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SocialLinkOptionCard(
                  size: size,
                  isDarkMode: isDarkMode,
                  text: "Website",
                ),
                SizedBox(
                  width: 8,
                ),
                SocialLinkOptionCard(
                  size: size,
                  isDarkMode: isDarkMode,
                  text: "LinkedIn",
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showAddCompanyDetailsModal(BuildContext context) {
    TextEditingController aboutCompanyController = TextEditingController();
    TextEditingController linkedinController = TextEditingController();
    TextEditingController websiteController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: MediaQuery.of(context).size.height / 1.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    ModalTopBar(),
                    const SizedBox(height: 25),
                    Text(
                      "About the Company",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Provide a brief overview of your company, including your mission, values, and key highlights to attract top talent.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: aboutCompanyController,
                      maxLength: 1000,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: "About Company*",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: linkedinController,
                      decoration: InputDecoration(
                        labelText: "LinkedIn Profile (Optional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: websiteController,
                      decoration: InputDecoration(
                        labelText: "Company Website (Optional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      GestureDetector(
                        onTap: () {
                          // Save logic here
                          final aboutCompany = aboutCompanyController.text;
                          final linkedinLink = linkedinController.text;
                          final websiteLink = websiteController.text;

                          if (aboutCompany.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("About Company is required."),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            // Perform save action
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SocialLinkOptionCard extends StatelessWidget {
  final String text;

  const SocialLinkOptionCard(
      {super.key,
      required this.size,
      required this.isDarkMode,
      required this.text});

  final Size size;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 4,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color:
                    isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700),
          ),
          SizedBox(
            width: 3,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
            size: 17,
          ),
        ],
      ),
    );
  }
}
