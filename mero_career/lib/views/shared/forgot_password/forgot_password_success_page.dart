import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mero_career/views/shared/login/login_page.dart';

import '../../../services/otp_services.dart';
import '../../widgets/custom_flushbar_message.dart';
import '../../widgets/my_button.dart';

class ForgotPasswordSuccessPage extends StatefulWidget {
  final String email;

  const ForgotPasswordSuccessPage({super.key, required this.email});

  @override
  State<ForgotPasswordSuccessPage> createState() =>
      _ForgotPasswordSuccessPageState();
}

class _ForgotPasswordSuccessPageState extends State<ForgotPasswordSuccessPage> {
  OtpServices otpServices = OtpServices();
  bool isLoading = false;

  void _handleForgotPassword() async {
    if (widget.email != "") {
      setState(() {
        isLoading = true;
      });
      try {
        final Map<String, dynamic> data = {'email': widget.email};
        final response = await otpServices.requestPasswordReset(data);

        if (response!.statusCode == 200) {
          showCustomFlushbar(
              context: context,
              message: "Successfully resent email !",
              type: MessageType.success,
              duration: 1200);
        } else {
          final responseData = await json.decode(response!.body);
          showCustomFlushbar(
              context: context,
              message: responseData['detail'],
              type: MessageType.error,
              duration: 1200);
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

    void handleSuccess() async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/email_send.png',
              height: 280,
              width: double.infinity,
            ),
            Text(
              "Password Reset Email Sent",
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 23, fontWeight: FontWeight.w700, letterSpacing: 1),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "If this email is registered, we've sent you a link to reset your password. Please check your mail to reset password.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: 30,
            ),
            MyButton(
                color: Colors.blue.shade600,
                width: size.width / 1.5,
                height: 45,
                isLoading: isLoading,
                onTap: handleSuccess,
                text: "Done"),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _handleForgotPassword();
              },
              child: Text(
                "Resend Email ? ",
                style: TextStyle(
                    letterSpacing: 0.5, fontSize: 16, color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
