import 'package:flutter/material.dart';
import 'package:mero_career/views/widgets/my_button.dart';

class UserVerificationPage extends StatefulWidget {
  const UserVerificationPage({super.key});

  @override
  State<UserVerificationPage> createState() => _UserVerificationPageState();
}

class _UserVerificationPageState extends State<UserVerificationPage> {
  // Create four controllers for each text input field
  final TextEditingController _firstDigitController = TextEditingController();
  final TextEditingController _secondDigitController = TextEditingController();
  final TextEditingController _thirdDigitController = TextEditingController();
  final TextEditingController _fourthDigitController = TextEditingController();

  void _verifyCode() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the 4-digit verification code sent to your email.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5),
            ),
            SizedBox(height: 10),
            Text(
              "Please check your inbox and enter the code below.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Four Boxes for the 4-digit code
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCodeBox(controller: _firstDigitController),
                  _buildCodeBox(controller: _secondDigitController),
                  _buildCodeBox(controller: _thirdDigitController),
                  _buildCodeBox(controller: _fourthDigitController),
                ],
              ),
            ),
            SizedBox(height: 40),

            // Submit Button

            Center(
              child: MyButton(
                  color: Colors.blue.shade600,
                  width: size.width / 2.5,
                  height: 40,
                  onTap: _verifyCode,
                  text: "Verify Code"),
            ),

            // Resend code option
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(letterSpacing: 0.5, fontSize: 15),
                  ),
                  Text(
                    " Resend",
                    style: TextStyle(
                        color: Colors.blue, letterSpacing: 0.5, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a single input box for each digit
  Widget _buildCodeBox({required TextEditingController controller}) {
    return Container(
      width: 55,
      height: 55, // Ensuring consistent height for each box
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade300,
          // Using your app's primary color for the border
          width: 2,
        ),
        // Light background for the input fields
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '', // Hide the counter text
          border: InputBorder.none, // Remove default border
          hintText: '', // No hint text
        ),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        onChanged: (value) {
          // Automatically move focus to the next input field when a digit is entered
          if (value.length == 1) {
            if (_fourthDigitController.text.isEmpty) {
              FocusScope.of(context).nextFocus();
            }
          }
        },
        autofocus: false,
      ),
    );
  }
}
