import 'package:flutter/material.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/views/widgets/my_divider.dart';
import 'package:provider/provider.dart';

import '../../../../providers/job_provider.dart';
import '../../../../utils/date_formater.dart';

class PreviewHeadingForJobSeeker extends StatefulWidget {
  final String role;
  final Map<String, dynamic> profileData;

  const PreviewHeadingForJobSeeker({
    super.key,
    required this.profileData,
    required this.role,
  });

  @override
  State<PreviewHeadingForJobSeeker> createState() =>
      _PreviewHeadingForJobSeekerState();
}

class _PreviewHeadingForJobSeekerState
    extends State<PreviewHeadingForJobSeeker> {
  @override
  Widget build(BuildContext context) {
    final profileImage = widget.profileData['profile_image'] ??
        'https://via.placeholder.com/150';
    final fullName = widget.profileData['full_name'] ?? 'Unknown';
    final email = widget.profileData['email'] ?? 'N/A';
    final location = widget.profileData['address'] ?? 'Unknown';
    final phoneNumber = widget.profileData['phone_number'] ?? 'N/A';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18),
                      ),
                      Text(
                        email,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 13.5, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16.5,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                location,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 16.5,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                phoneNumber,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
