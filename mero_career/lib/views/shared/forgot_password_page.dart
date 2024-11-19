import 'package:flutter/material.dart';
import 'package:mero_career/views/shared/forgot_password_success_page.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  void _handleForgotPassword() async {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ForgotPasswordSuccessPage()));
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Enter your registered email address, and we'll send you a link to reset your password.",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
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
                onTap: _handleForgotPassword,
                text: "Submit")
          ],
        ),
      ),
    );
  }
}
