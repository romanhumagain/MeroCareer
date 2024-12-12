import 'package:flutter/material.dart';
import 'package:mero_career/providers/recruiter_provider.dart';
import 'package:mero_career/views/job_seekers/common/modal_top_bar.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:provider/provider.dart';

class CompanyBasicDetails extends StatelessWidget {
  const CompanyBasicDetails({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 1.15,
      height: size.height / 4.2,
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
                    "Company Basic Details",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 17),
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
            Consumer<RecruiterProvider>(builder: (context, provider, child) {
              final recruiterData = provider.recruiterProfileDetails;
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.card_travel,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(recruiterData?['company_type'])
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
                      Text(recruiterData?['address'])
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
                      Text(recruiterData?['phone_number'])
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
                      Text(recruiterData?['user_details']['email'])
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.app_registration,
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text(recruiterData?['registration_number'])
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
    final recruiterProvider =
        Provider.of<RecruiterProvider>(context, listen: false);

    // Initialize TextEditingController with Provider data
    final recruiterDetails = recruiterProvider.recruiterProfileDetails;
    TextEditingController companyNameController =
        TextEditingController(text: recruiterDetails?['company_name'] ?? "");
    TextEditingController companyTypeController =
        TextEditingController(text: recruiterDetails?['company_type'] ?? "");
    TextEditingController phoneNummberController =
        TextEditingController(text: recruiterDetails?['phone_number'] ?? "");
    TextEditingController emailController = TextEditingController(
        text: recruiterDetails?['user_details']['email'] ?? "");
    TextEditingController locationController =
        TextEditingController(text: recruiterDetails?['address'] ?? "");
    TextEditingController registrationNumberController = TextEditingController(
        text: recruiterDetails?['registration_number'] ?? "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Container(
          height: MediaQuery.of(context).size.height / 1.15,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(26), topRight: Radius.circular(26)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ModalTopBar(),
                      const SizedBox(height: 16),
                      const SizedBox(height: 16),
                      Text("Company Basic Details",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: 20)),
                      const SizedBox(height: 8),
                      Text(
                        "These are the basic details of your company. You can also update them.",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: recruiterDetails?[
                                          'company_profile_image'] !=
                                      null
                                  ? NetworkImage(recruiterDetails?[
                                      'company_profile_image'])
                                  : const AssetImage(
                                          'assets/images/company_logo/default_company_pic.png')
                                      as ImageProvider,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Trigger image update functionality
                                _updateImage(context);
                              },
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: companyNameController,
                              labelText: "Company Name",
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: companyTypeController,
                              labelText: "Company Type",
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: emailController,
                              labelText: "Email",
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: phoneNummberController,
                              labelText: "Phone Number",
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: locationController,
                              labelText: "Location",
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: registrationNumberController,
                              labelText: "Registration Number",
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
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 25),
                      GestureDetector(
                        onTap: () async {
                          // Gather updated data
                          Map<String, dynamic> updatedData = {
                            "company_name": companyNameController.text,
                            "company_type": companyTypeController.text,
                            "phone_number": phoneNummberController.text,
                            "address": locationController.text,
                            "registration_number":
                                registrationNumberController.text,
                          };
                          _updateData(updatedData, recruiterProvider, context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.5,
                                color: Colors.white),
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
    // Close the bottom sheet after the message is shown
    Navigator.pop(context);
  }

// Method to handle image update
  void _updateImage(BuildContext context) async {
    // Logic for updating the image
    // This can include opening a file picker or capturing a new image
    print("Update image clicked");
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
