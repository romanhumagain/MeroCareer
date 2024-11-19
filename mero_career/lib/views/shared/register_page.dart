import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _registerUser() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  child: Image.asset(
                'assets/images/logo.png',
                height: 50,
              )),
              Text(
                "Lets Create Your Account",
                style: GoogleFonts.openSans(
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextfield(
                      controller: _firstNameController,
                      labelText: 'First Name',
                      prefixIcon: CupertinoIcons.person_solid,
                      verticalContentPadding: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: MyTextfield(
                      controller: _lastNameController,
                      labelText: 'Last Name',
                      prefixIcon: CupertinoIcons.person_solid,
                      verticalContentPadding: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              MyTextfield(
                controller: _usernameController,
                labelText: 'Username',
                prefixIcon: CupertinoIcons.person_add_solid,
                verticalContentPadding: 13.5,
              ),
              SizedBox(
                height: 17,
              ),
              MyTextfield(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: Icons.mail,
                verticalContentPadding: 13.5,
              ),

              SizedBox(
                height: 17,
              ),
              MyPasswordfield(
                controller: _passwordController,
                labelText: "Password",
                verticalContentPadding: 13.5,
              ),
              SizedBox(
                height: 17,
              ),
              MyPasswordfield(
                controller: _confirmPasswordController,
                labelText: "Confirm Password",
                verticalContentPadding: 13.5,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.blue.shade600,
                  ),
                  Text(
                    "I agree to ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    "Privacy Policy ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                  Text(
                    "and ",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    "Terms of use ",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MyButton(
                color: Colors.blue,
                width: size.width,
                height: 44,
                text: "Sign Up",
                onTap: _registerUser,
              ),
              // MyButton(color: Colors.blue, size: size, text: "Sign In"),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.blue,
                            letterSpacing: 0.5)),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "Or sign up with",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey,
                            letterSpacing: 0.5),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SocialOption(
                    imageUrl: 'assets/images/google.png',
                  ),
                  SizedBox(width: 15),
                  SocialOption(
                    imageUrl: 'assets/images/linkedin.png',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
