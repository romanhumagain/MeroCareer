import 'package:flutter/material.dart';
import 'package:mero_career/providers/recruiter_provider.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../providers/theme_provider.dart';
import '../../../widgets/custom_flushbar_message.dart';

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

    final recruiterProvider =
        Provider.of<RecruiterProvider>(context, listen: true);

    return Container(
        width: widget.size.width / 1.15,
        // height: widget.size.height / 5.5,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  recruiterProvider.recruiterProfileDetails?['company_summary']
                              ?.trim()
                              .isEmpty ??
                          true
                      ? GestureDetector(
                          onTap: () {
                            _showAddCompanyDetailsModal(context);
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _showAddCompanyDetailsModal(context);
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              recruiterProvider.recruiterProfileDetails?['company_summary']
                          ?.trim()
                          .isEmpty ??
                      true
                  ? Column(
                      children: [
                        Text(
                          "Highlight your company’s achievements and values to attract top talent.",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color: Colors.grey.shade600,
                                  fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Row of social link options (Website and LinkedIn)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialLinkOptionCard(
                              size: size,
                              isDarkMode: isDarkMode,
                              text: "Website",
                              // icon: Icons.language, // Example icon for Website
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            SocialLinkOptionCard(
                              size: size,
                              isDarkMode: isDarkMode,
                              text: "LinkedIn",
                              // icon: Icons.linked_in, // LinkedIn icon
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            recruiterProvider.recruiterProfileDetails?[
                                    'company_summary'] ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                        // Display Website and LinkedIn if available
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (recruiterProvider
                                    .recruiterProfileDetails?['website_link'] !=
                                null)
                              FinalSocialLinkOptionCard(
                                size: size,
                                isDarkMode: isDarkMode,
                                text: "Website",
                                icon: Icons.language,
                                url: recruiterProvider.recruiterProfileDetails?[
                                    'company_website'],
                              ),
                            SizedBox(
                              width: 15,
                            ),
                            if (recruiterProvider.recruiterProfileDetails?[
                                    'company_linkedin'] !=
                                null)
                              SizedBox(
                                width: 12,
                              ),
                            if (recruiterProvider.recruiterProfileDetails?[
                                    'linkedin_link'] !=
                                null)
                              FinalSocialLinkOptionCard(
                                size: size,
                                isDarkMode: isDarkMode,
                                text: "LinkedIn",
                                icon: Icons.account_box,
                                url: recruiterProvider.recruiterProfileDetails?[
                                    'company_linkedin'],
                              ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ));
  }

  void _showAddCompanyDetailsModal(BuildContext context) {
    final recruiterProvider =
        Provider.of<RecruiterProvider>(context, listen: false);
    TextEditingController aboutCompanyController = TextEditingController(
        text: recruiterProvider.recruiterProfileDetails?['company_summary']);
    TextEditingController linkedinController = TextEditingController(
        text: recruiterProvider.recruiterProfileDetails?['linkedin_link']);
    TextEditingController websiteController = TextEditingController(
        text: recruiterProvider.recruiterProfileDetails?['website_link']);

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
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
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: aboutCompanyController,
                        maxLength: 1000,
                        maxLines: 6,
                        validator: (value) {
                          if (value == "" || value!.isEmpty) {
                            return "Please write about your company before updating";
                          }
                          return null;
                        },
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
                      const SizedBox(height: 20),
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
                            final recruiterProvider =
                                Provider.of<RecruiterProvider>(context,
                                    listen: false);

                            if (_formKey.currentState?.validate() ?? false) {
                              final aboutCompany = aboutCompanyController.text;
                              final linkedinLink = linkedinController.text;
                              final websiteLink = websiteController.text;

                              final Map<String, dynamic> updatedData = {
                                'company_summary': aboutCompany,
                                'linkedin_link': linkedinLink,
                                'website_link': websiteLink
                              };

                              _updateData(
                                  updatedData, recruiterProvider, context);
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
          ),
        );
      },
    );
  }

  void _updateData(Map<String, dynamic> updatedData, recruiterProvider,
      BuildContext context) async {
    final response =
        await recruiterProvider.updateRecruiterProfile(updatedData);

    // Show appropriate message based on response
    if (response != null && response.statusCode == 200) {
      showCustomFlushbar(
        context: context,
        message: "Successfully updated data!",
        type: MessageType.success,
      );
    } else {
      showCustomFlushbar(
        context: context,
        message: "Failed to update profile. Please try again.",
        type: MessageType.error,
      );
    }
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
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

class FinalSocialLinkOptionCard extends StatelessWidget {
  final Size size;
  final bool isDarkMode;
  final String text;
  final IconData icon;
  final String? url;

  const FinalSocialLinkOptionCard({
    required this.size,
    required this.isDarkMode,
    required this.text,
    required this.icon,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url != null) {
          launchUrl(url! as Uri); // Open URL in browser
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode ? Colors.grey.shade800 : Colors.blue.shade50,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
