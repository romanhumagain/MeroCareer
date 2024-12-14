import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mero_career/providers/job_seeker_job_provider.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/menu/screen/applied_job_screen.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/screen/job_seeker_profile_preview.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';
import '../../../widgets/custom_textfield.dart';
import '../../common/modal_top_bar.dart';

class ProfileHeadingSection extends StatelessWidget {
  const ProfileHeadingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    final headingTextStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
    return Consumer<ProfileSetupProvider>(builder: (context, provider, child) {
      final jobSeekerDetails = provider.jobSeekerProfileDetails;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundImage: jobSeekerDetails?['profile_image'] !=
                                  null
                              ? NetworkImage(jobSeekerDetails?['profile_image'])
                              : AssetImage('assets/images/blank_pp.png')
                                  as ImageProvider, // Cast AssetImage to ImageProvider
                        )),
                    Text(
                      jobSeekerDetails?['full_name'] ?? '...Loading',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 18, letterSpacing: 0.4),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    jobSeekerDetails?['profile_headline']?.isNotEmpty ?? false
                        ? Text(
                            jobSeekerDetails?['profile_headline'],
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 15, letterSpacing: 0.4),
                          )
                        : Text(
                            'Add short profile headline...',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: 11, letterSpacing: 0.2),
                          ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  showHeadingTopScreen(context);
                },
                child: Icon(
                  Icons.mode_edit_outline,
                  size: 22,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<JobSeekerJobProvider>(builder: (context, provider, child) {
            final appliedJobDetails = provider.appliedJobCount;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliedJobScreen()));
                  },
                  child: Column(
                    children: [
                      Text(
                        appliedJobDetails!['applied_job'].toString(),
                        style: headingTextStyle?.copyWith(
                            fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        "Job Applied",
                        style: headingTextStyle,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: 2,
                  height: 30,
                  color: Theme.of(context).colorScheme.surface,
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppliedJobScreen()));
                  },
                  child: Column(
                    children: [
                      Text(
                        appliedJobDetails['application_under_review']
                            .toString(),
                        style: headingTextStyle?.copyWith(
                            fontSize: 16, color: Colors.blue),
                      ),
                      Text(
                        "Application Under Review",
                        style: headingTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.eye_solid,
                size: 19,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobSeekerProfilePreview(
                                jobSeekerId: 1,
                              )));
                },
                child: Text(
                  "Preview Profile",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void showHeadingTopScreen(BuildContext context) {
    final jobSeekerProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);

    // Text controllers
    TextEditingController fullNameController = TextEditingController(
      text: jobSeekerProvider.jobSeekerProfileDetails?['full_name'] ??
          '..Loading',
    );
    TextEditingController profileHeadlineController = TextEditingController(
      text: jobSeekerProvider.jobSeekerProfileDetails?['profile_headline'] ??
          '..Loading',
    );

    final ImagePicker picker = ImagePicker();
    XFile? selectedImage;

    Future<void> pickImage(StateSetter setModalState) async {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setModalState(() {
          selectedImage = image;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile image updated!")),
        );
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final size = MediaQuery.of(context).size;

        return StatefulBuilder(builder: (context, setModalState) {
          return Container(
            height: size.height / 1.15,
            width: size.width,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26),
                topRight: Radius.circular(26),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      ModalTopBar(),
                      const SizedBox(height: 25),
                      Text(
                        "Introduction",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 21.5, letterSpacing: 0.4),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Add details about your preferred job profile. This helps us personalize your job recommendations.",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 30),
                      // Image Upload Section
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => pickImage(setModalState),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: isDarkMode
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300,
                                backgroundImage: selectedImage != null
                                    ? FileImage(File(selectedImage!.path))
                                    : (jobSeekerProvider
                                                    .jobSeekerProfileDetails?[
                                                'profile_image'] !=
                                            null
                                        ? NetworkImage(
                                            jobSeekerProvider
                                                    .jobSeekerProfileDetails![
                                                'profile_image'],
                                          )
                                        : null),
                                child: (selectedImage == null &&
                                        jobSeekerProvider
                                                    .jobSeekerProfileDetails?[
                                                'profile_image'] ==
                                            null)
                                    ? Icon(
                                        Icons.camera_alt,
                                        size: 30,
                                        color: isDarkMode
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Upload Profile Image",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: fullNameController,
                              labelText: "Full Name",
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              controller: profileHeadlineController,
                              labelText: "Profile Headline",
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Write a concise headline introducing yourself to employers",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 15),
                          ],
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
                          child: const Text(
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
                          onTap: () async {
                            Map<String, dynamic> profileData = {
                              'full_name': fullNameController.text,
                              'profile_headline':
                                  profileHeadlineController.text,
                            };
                            await jobSeekerProvider
                                .updateJobSeekerProfileDetails(
                                    context, profileData);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: const Text(
                              "Save Changes",
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
        });
      },
    );
  }
}
