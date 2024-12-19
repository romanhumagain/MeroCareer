import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/services/otp_services.dart';
import 'package:mero_career/views/shared/forgot_password/forgot_password_success_page.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  OtpServices otpServices = OtpServices();
  bool isLoading = false;

  void _handleForgotPassword() async {
    if (_emailController.text != "") {
      setState(() {
        isLoading = true;
      });
      try {
        final Map<String, dynamic> data = {
          'email': _emailController.text.trim()
        };
        final response = await otpServices.requestPasswordReset(data);

        if (response!.statusCode == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ForgotPasswordSuccessPage(
                      email: _emailController.text.trim())));
        } else {
          final responseData = await json.decode(response!.body);
          showCustomFlushbar(
              context: context,
              message: responseData['detail'],
              type: MessageType.error,
              duration: 1600);
        }
      } catch (e) {
        print("Error sending email ! , $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      showCustomFlushbar(
          context: context,
          message: "Please provide your registered email address !",
          type: MessageType.warning,
          duration: 1200);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forgot Password",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter your registered email address, and we'll send you a link to reset your password.",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
                controller: _emailController,
                labelText: "E-mail",
                prefixIcon: Icons.email_rounded,
                verticalContentPadding: 13.5),
            SizedBox(
              height: 25,
            ),
            MyButton(
                color: Colors.blue.shade600,
                width: size.width,
                height: 45,
                isLoading: isLoading,
                onTap: _handleForgotPassword,
                text: "Submit")
          ],
        ),
      ),
    );
  }
}
