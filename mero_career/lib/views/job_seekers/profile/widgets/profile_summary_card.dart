import 'package:flutter/material.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_seeker_provider.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAddProfileSummarySection(context);
      },
      child: Container(
        width: size.width / 1.15,
        // height: size.height / 8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Consumer<ProfileSetupProvider>(
              builder: (context, provider, child) {
            final profileDetails = provider.jobSeekerProfileDetails;
            final isProfileSummaryAdded =
                profileDetails?['profile_summary']?.isNotEmpty ?? false;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile Summary",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 17.2),
                    ),
                    !isProfileSummaryAdded
                        ? Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        : Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )
                  ],
                ),
                SizedBox(height: 10),
                !isProfileSummaryAdded
                    ? Text(
                        "Highlight your key career achievements to help recruiters know your potential",
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    : Text(
                        profileDetails?['profile_summary'],
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void showAddProfileSummarySection(BuildContext context) {
    final jobSeekerProfileProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);

    final TextEditingController profileSummaryController =
        TextEditingController(
            text: jobSeekerProfileProvider
                .jobSeekerProfileDetails?['profile_summary']);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: size.height / 1.15,
          width: size.width,
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
                    const ModalTopBar(),
                    const SizedBox(height: 25),
                    Text(
                      "Profile Summary",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Give recruiters a brief overview of the highlights of your career, key achievements and career goals to help recruiters know your profile better",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: profileSummaryController,
                      maxLength: 1000,
                      minLines: 1,
                      maxLines: null,
                      decoration: const InputDecoration(
                        label: Text(
                          "Profile Summary*",
                          style: TextStyle(fontSize: 15.5),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 25,
                  ),
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
                        onTap: () async {
                          Map<String, dynamic> profileData = {
                            'profile_summary': profileSummaryController.text
                          };
                          await jobSeekerProfileProvider
                              .updateJobSeekerProfileDetails(
                                  context, profileData);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Save Changes",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
