import 'package:flutter/material.dart';
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:provider/provider.dart';

class BasicDetailsCard extends StatelessWidget {
  const BasicDetailsCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Basic Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17.3),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBasicDetailsBottomSheet(context);
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Consumer<ProfileSetupProvider>(builder: (context, provider, child) {
              final jobSeekerDetails = provider.jobSeekerProfileDetails;
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(jobSeekerDetails?['full_name'])
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(jobSeekerDetails?['email'])
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(jobSeekerDetails?['address'])
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(jobSeekerDetails?['phone_number'])
                    ],
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  void _showBasicDetailsBottomSheet(BuildContext context) {
    final jobSeekerProvider =
        Provider.of<ProfileSetupProvider>(context, listen: false);

    TextEditingController fullNameController = TextEditingController(
        text: jobSeekerProvider.jobSeekerProfileDetails?['full_name']);
    TextEditingController usernameController = TextEditingController(
        text: jobSeekerProvider.jobSeekerProfileDetails?['username']);
    TextEditingController phoneNummberController = TextEditingController(
        text: jobSeekerProvider.jobSeekerProfileDetails?['phone_number']);
    TextEditingController emailController = TextEditingController(
        text: jobSeekerProvider.jobSeekerProfileDetails?['email']);
    TextEditingController locationController = TextEditingController(
        text: jobSeekerProvider.jobSeekerProfileDetails?['address']);

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: size.height / 1.15,
            width: size.width,
            decoration: BoxDecoration(
                color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModalTopBar(),
                        SizedBox(
                          height: 24,
                        ),
                        Text("Profile Basics Details",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontSize: 20)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "These are the basics details of your profile. You can also update it.",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            children: [
                              CustomTextField(
                                controller: fullNameController,
                                labelText: "Full Name",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: usernameController,
                                labelText: "Username",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: emailController,
                                labelText: "Email",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: phoneNummberController,
                                labelText: "Phone Number",
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CustomTextField(
                                controller: locationController,
                                labelText: "Address",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                                color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Map<String, dynamic> profileData = {
                              'full_name': fullNameController.text,
                              'username': usernameController.text,
                              'phone_number': phoneNummberController.text,
                              'email': emailController.text,
                              'address': locationController.text,
                            };
                            await jobSeekerProvider
                                .updateJobSeekerProfileDetails(
                                    context, profileData);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: Text(
                              "Save Changes",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.5,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomTextField(
      {super.key, required this.controller, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8),
          label: Text(
            '$labelText*',
            style: TextStyle(fontSize: 15),
            // softWrap: true,
            // overflow: TextOverflow.visible,
          )),
    );
  }
}
