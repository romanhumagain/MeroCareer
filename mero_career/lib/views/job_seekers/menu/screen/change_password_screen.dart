import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';

import '../../../shared/login/login_page.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  JobSeekerServices jobSeekerServices = JobSeekerServices();
  AuthServices authServices = AuthServices();
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void handlePasswordChange() async {
    if (_formKey.currentState!.validate() ?? false) {
      Map<String, dynamic> credentialsData = {
        'current_password': currentPasswordController.text.trim(),
        'new_password': newPasswordController.text.trim(),
        'confirm_new_password': confirmPasswordController.text.trim()
      };

      try {
        setState(() {
          isLoading = true;
        });
        final response =
            await jobSeekerServices.changeAccountPassword(credentialsData);

        if (response.statusCode == 200) {
          showCustomFlushbar(
              context: context,
              message:
                  "Successfully Changed Password ! Please login you account again !",
              type: MessageType.success,
              duration: 1000);
          await authServices.logoutUser();
          await Future.delayed(Duration(milliseconds: 2200));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        } else if (response.statusCode == 400) {
          final responseData = json.decode(response.body);
          showCustomFlushbar(
              context: context,
              message: responseData['detail'],
              type: MessageType.error,
              duration: 2000);
        }
      } catch (e) {
        print("Error changin password $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyPasswordfield(
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Please enter your current password";
                              }
                              return null;
                            },
                            labelText: "Current Password",
                            verticalContentPadding: 13,
                            controller: currentPasswordController),
                        SizedBox(
                          height: 18,
                        ),
                        MyPasswordfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'New Password cannot be empty';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            labelText: "New Password",
                            verticalContentPadding: 13,
                            controller: newPasswordController),
                        SizedBox(
                          height: 18,
                        ),
                        MyPasswordfield(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != newPasswordController.text) {
                                return "Password Didn't Matched";
                              }
                              return null;
                            },
                            labelText: "Confirm New Password",
                            verticalContentPadding: 13,
                            controller: confirmPasswordController),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
                  onTap: () {
                    isLoading ? () {} : handlePasswordChange();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
