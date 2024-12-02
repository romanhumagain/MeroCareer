import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mero_career/views/recruiters/job_seeker_review/screen/job_seeker_profile_preview.dart';

import '../../../widgets/custom_textfield.dart';
import '../../common/modal_top_bar.dart';

class ProfileHeadingSection extends StatelessWidget {
  const ProfileHeadingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final headingTextStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400);
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
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(
                        'assets/images/pp.jpg',
                      ),
                    ),
                  ),
                  Text(
                    "Roman Humagain",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontSize: 18, letterSpacing: 0.4),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mobile App Developer",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 15, letterSpacing: 0.4),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "2",
                  style: headingTextStyle?.copyWith(
                      fontSize: 15.5, color: Colors.blue),
                ),
                Text(
                  "Job Applied",
                  style: headingTextStyle,
                )
              ],
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
            Column(
              children: [
                Text(
                  "0",
                  style: headingTextStyle?.copyWith(
                      fontSize: 15.5, color: Colors.blue),
                ),
                Text(
                  "Application Under Review",
                  style: headingTextStyle,
                )
              ],
            ),
          ],
        ),
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
                        builder: (context) => JobSeekerProfilePreview()));
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
  }

  void showHeadingTopScreen(BuildContext context) {
    TextEditingController _fullNameController =
        TextEditingController(text: "Roman Humagain");
    TextEditingController _profileHeadlineController = TextEditingController();
    final ImagePicker _picker = ImagePicker();
    XFile? _selectedImage;

    Future<void> _pickImage() async {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _selectedImage = image;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile image updated!"),
        ));
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final size = MediaQuery.of(context).size;
        return Container(
          height: size.height / 1.15,
          width: size.width,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
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
                    SizedBox(height: 4),
                    ModalTopBar(),
                    SizedBox(height: 25),
                    Text(
                      "Introduction",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 21.5, letterSpacing: 0.4),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Add details about your preferred job profile. This helps us personalize your job recommendations.",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(height: 30),
                    // Image Upload Section
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              backgroundImage: _selectedImage != null
                                  ? FileImage(File(_selectedImage!.path))
                                      as ImageProvider
                                  : null,
                              child: _selectedImage == null
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
                          SizedBox(height: 8),
                          Text(
                            "Upload Profile Image",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _fullNameController,
                            labelText: "Full Name",
                          ),
                          SizedBox(height: 15),
                          CustomTextField(
                            controller: _profileHeadlineController,
                            labelText: "Profile Headline",
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Write a concise headline introducing yourself to employers",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: 15),
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
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.5,
                            color: Colors.white,
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
