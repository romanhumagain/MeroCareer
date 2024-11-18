import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(child: Image.asset('assets/images/logo.png', height: 95,)),
                ],
              ),

              const SizedBox(
                height: 5,
              ),

              // welcome msg=
              Text(
                "MeroCareer",
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Get started with your job search today.",
                style:
                    TextStyle(fontWeight: FontWeight.w400, letterSpacing: 1.07),
              ),
              const SizedBox(
                height: 45,
              ),
              const MyTextfield(),
              const SizedBox(
                height: 20,
              ),
              const MyPasswordfield(),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // CheckboxListTile(value: true, onChanged: (value){})
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Colors.blue,
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, letterSpacing: 1.3),
                      )
                    ],
                  ),
                  Text("Forgot Password ?", style: TextStyle(color: Colors.grey),)
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              MyButton(color: Colors.blue, size: size, text: "Sign In"),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Create a new account ?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: 1.0085),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Register here",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.blue,
                          letterSpacing: 1.05))
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("Or sign in with", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          letterSpacing: 1.0085),),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SocialOption(imageUrl: 'assets/images/google.png',),
                  SizedBox(width: 15),
                  SocialOption(imageUrl: 'assets/images/linkedin.png',),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialOption extends StatelessWidget {
  final String imageUrl;
  const SocialOption({
    super.key,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(100)
      ),
      child: ClipRRect(
          child: Image.asset(imageUrl, height: 28,)),
    );
  }
}
