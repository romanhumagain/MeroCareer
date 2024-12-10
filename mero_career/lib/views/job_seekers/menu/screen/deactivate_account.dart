import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/views/widgets/custom_confirmation_message.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';

import '../../../shared/login/login_page.dart';
import '../../../widgets/custom_flushbar_message.dart';
import '../../../widgets/my_button.dart';

class DeactivateAccount extends StatefulWidget {
  const DeactivateAccount({super.key});

  @override
  State<DeactivateAccount> createState() => _DeactivateAccountState();
}

class _DeactivateAccountState extends State<DeactivateAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  JobSeekerServices jobSeekerServices = JobSeekerServices();
  AuthServices authServices = AuthServices();
  bool isLoading = false;

  void handleAccountDeactivate() async {
    if (_formKey.currentState!.validate() ?? false) {
      bool isConfirmed = await showCustomConfirmationDialog(context,
          "Are you sure you want to deactivate your account? This action can be reversed by logging back in.");

      if (isConfirmed) {
        Map<String, dynamic> credentialsData = {
          'password': passwordController.text
        };

        try {
          setState(() {
            isLoading = true;
          });
          final response =
              await jobSeekerServices.deactivateAccount(credentialsData);
          if (response.statusCode == 200) {
            showCustomFlushbar(
                context: context,
                message:
                    "Successfully Deactivated Account ! Contact Owner for reactivation !",
                type: MessageType.success,
                duration: 1200);
            await authServices.logoutUser();
            await Future.delayed(Duration(milliseconds: 2400));
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
        } finally {
          setState(() {
            isLoading = false;
          });
        }
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
        title: const Text("Account Settings"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
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
                  validator: (value) {
                    if (value!.isEmpty || value == "") {
                      return "Please enter your current password";
                    }
                    return null;
                  },
                  labelText: "Password",
                  verticalContentPadding: 13.5,
                  controller: passwordController,
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
                      handleAccountDeactivate();
                    },
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
