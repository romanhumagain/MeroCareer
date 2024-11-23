import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mero_career/views/job_seekers/profile_setup/widget/continue_skip.dart';

class ProfilePictureAddScreen extends StatefulWidget {
  const ProfilePictureAddScreen({super.key});

  @override
  State<ProfilePictureAddScreen> createState() =>
      _ProfilePictureAddScreenState();
}

class _ProfilePictureAddScreenState extends State<ProfilePictureAddScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      // Opening gallery to pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Let's finish setup by adding your profile photo",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          height: 135,
                          width: 135,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/blank_pp.png',
                          height: 125,
                          width: 125,
                        ),
                ),
                const SizedBox(height: 5),
                Text(
                  _selectedImage == null ? "No Image Selected!" : '',
                  style: const TextStyle(fontSize: 14.5),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    width: size.width / 1.9,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14)),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Choose from gallery",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
          ContinueSkip(onContinue: () {}),
        ],
      ),
    );
  }
}
