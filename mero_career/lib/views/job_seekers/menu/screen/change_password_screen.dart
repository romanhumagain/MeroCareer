import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text("Account Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 21.5),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Maintain your account by regularly updating your password for enhanced protection",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      MyPasswordfield(
                          labelText: "Current Password",
                          verticalContentPadding: 13,
                          controller: currentPasswordController),
                      SizedBox(
                        height: 18,
                      ),
                      MyPasswordfield(
                          labelText: "New Password",
                          verticalContentPadding: 13,
                          controller: newPasswordController),
                      SizedBox(
                        height: 18,
                      ),
                      MyPasswordfield(
                          labelText: "Confirm New Password",
                          verticalContentPadding: 13,
                          controller: confirmPasswordController),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: MyButton(
                  color: Colors.blue,
                  width: size.width / 1.2,
                  height: 42,
                  text: "Save Changes",
                  onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
