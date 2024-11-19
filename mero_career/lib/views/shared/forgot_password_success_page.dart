import 'package:flutter/material.dart';
import 'package:mero_career/views/shared/login_page.dart';

import '../widgets/my_button.dart';

class ForgotPasswordSuccessPage extends StatelessWidget {
  const ForgotPasswordSuccessPage({super.key});

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
                onTap: handleSuccess,
                text: "Done"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Resend Email ? ",
              style: TextStyle(
                  letterSpacing: 0.5, fontSize: 16, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
