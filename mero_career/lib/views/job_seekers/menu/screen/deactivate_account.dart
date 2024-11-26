import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';

import '../../../widgets/my_button.dart';

class DeactivateAccount extends StatelessWidget {
  const DeactivateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                "Deactivate Account",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 21.5),
              ),
              const SizedBox(height: 10),
              Text(
                "Deactivating your account will disable your profile and remove your presence from the platform. This action is reversible, but your data will be inaccessible until you reactivate your account.",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14.5,
                      color: Colors.grey.shade600,
                    ),
              ),
              const SizedBox(height: 28),
              MyPasswordfield(
                labelText: "Password",
                verticalContentPadding: 13.5,
                controller: _passwordController,
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  color: Colors.red,
                  width: size.width / 2,
                  height: 42,
                  text: "Deactivate",
                  onTap: () {
                    _showConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Deactivation"),
          content: const Text(
              "Are you sure you want to deactivate your account? This action can be reversed by logging back in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Perform deactivation logic here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "Deactivate",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
