import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/views/recruiters/common/recruiter_main_screen.dart';
import 'package:mero_career/views/recruiters/home/screen/home_screen.dart';
import 'package:mero_career/views/shared/forgot_password/forgot_password_page.dart';
import 'package:mero_career/views/shared/register/register_page.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

import '../../job_seekers/common/main_screen.dart';
import '../../widgets/custom_flushbar_message.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });
      final loginCredentials = {
        'email': _emailController.text,
        'password': _passwordController.text
      };
      try {
        AuthServices authServices = AuthServices();
        final response = await authServices.loginUser(loginCredentials);

        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          // setting the tokens
          await authServices.saveTokens(
              responseData['refresh'], responseData['access']);
          await authServices.saveRole(responseData['role']);

          showCustomFlushbar(
            context: context,
            message:
                "Successfully Logged in., Please verify your account now !",
            type: MessageType.success,
          );

          Timer(const Duration(seconds: 3), () {
            if (responseData['role'] == 'job_seeker') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            } else if (responseData['role'] == "recruiter") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecruiterMainScreen()),
              );
            } else {
              print("Unknown User!");
            }
          });
        } else if (response.statusCode == 401) {
          showCustomFlushbar(
            context: context,
            message: "Invalid Credentials !",
            type: MessageType.error,
          );
        } else if (response.statusCode == 400) {
          showCustomFlushbar(
            context: context,
            message: "Please check your credentials properly !",
            type: MessageType.error,
          );
        } else if (response.statusCode == 500) {
          showCustomFlushbar(
            context: context,
            message: "Server error. Please try again later.",
            type: MessageType.error,
          );
        } else {
          showCustomFlushbar(
            context: context,
            message: "Unexpected error occurred. Please try again later.",
            type: MessageType.error,
          );
        }
      } catch (e) {
        if (e is SocketException) {
          showCustomFlushbar(
            context: context,
            message: "No internet connection. Please check your connection.",
            type: MessageType.error,
          );
        } else {
          showCustomFlushbar(
            context: context,
            message: "Something went wrong. Please try again later.",
            type: MessageType.error,
          );
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    )),
                  ],
                ),

                // welcome msg=
                Text(
                  "MeroCareer",
                  style: GoogleFonts.openSans(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontSize: 24.5)),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Get started with your job search today.",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontSize: 15),
                ),
                const SizedBox(
                  height: 35,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextfield(
                        controller: _emailController,
                        labelText: 'E-mail',
                        prefixIcon: Icons.email_rounded,
                        verticalContentPadding: 14,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Enter a valid registered email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      MyPasswordfield(
                        controller: _passwordController,
                        verticalContentPadding: 14,
                        labelText: "Password",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please provide your valid password !';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 2,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 15),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      MyButton(
                          color: Colors.blue.shade600,
                          width: size.width,
                          onTap: _handleLogin,
                          isLoading: _isLoading,
                          height: 45,
                          text: "Sign In"),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create a new account ?",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text("Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5,
                              color: Colors.blue,
                              letterSpacing: 0.4)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Text("Continue as Recruiter",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.blue,
                              letterSpacing: 0.4)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58.0),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Or sign in with",
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
                SizedBox(height: 25),

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
      ),
    );
  }
}

class SocialOption extends StatelessWidget {
  final String imageUrl;

  const SocialOption({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
          child: Image.asset(
        imageUrl,
        height: 28,
      )),
    );
  }
}
