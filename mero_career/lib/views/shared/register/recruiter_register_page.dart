import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/recruiter_services.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/register/user_verification_page.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_flushbar_message.dart';
import '../login/login_page.dart';

class RecruiterRegisterPage extends StatefulWidget {
  const RecruiterRegisterPage({super.key});

  @override
  State<RecruiterRegisterPage> createState() => _RecruiterRegisterPageState();
}

class _RecruiterRegisterPageState extends State<RecruiterRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isTermsAndConditionAccepted = false;

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _registrationNumbeController =
      TextEditingController();
  final TextEditingController _panNumberController = TextEditingController();
  final TextEditingController _companyTypeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Profile image updated!"),
      ));
    }
  }

  void _clearFields() {
    _companyNameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _addressController.clear();
    _companyTypeController.clear();
    _registrationNumbeController.clear();
    _panNumberController.clear();
    _passwordController.clear();
  }

  AuthServices authServices = AuthServices();

  void _registerCompany() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!isTermsAndConditionAccepted) {
        showCustomFlushbar(
            context: context,
            message: "Accept terms and condition before registering account.",
            type: MessageType.warning,
            duration: 1500);
        return;
      }
      setState(() {
        _isLoading = true;
      });

      final recruiterData = {
        'company_name': _companyNameController.text,
        'email': _emailController.text,
        'phone_number': _phoneNumberController.text,
        'address': _addressController.text,
        'company_type': _companyTypeController.text,
        'registration_number': _registrationNumbeController.text,
        'pan_number': _panNumberController.text,
        'password': _passwordController.text,
        'role': 'recruiter',
      };

      try {
        RecruiterServices recruiterServices = RecruiterServices();
        final response =
            await recruiterServices.registerRecruiter(recruiterData);

        final responseData = json.decode(response.body);

        if (response.statusCode == 201) {
          // setting the tokens
          await authServices.saveTokens(
              responseData['refresh'], responseData['access']);
          await authServices.saveUserRole(responseData['role']);
          await authServices
              .saveVerificationStatus(responseData['is_verified']);
          await authServices
              .saveRecruiterApprovalStatus(responseData['is_approved']);

          showCustomFlushbar(
              context: context,
              message:
                  "Successfully registered your account. Please verify your account now !.",
              type: MessageType.success,
              duration: 1600);

          await Future.delayed(Duration(seconds: 2));
          _clearFields();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserVerificationPage()));
        } else if (response.statusCode == 400) {
          showCustomFlushbar(
              context: context,
              message: responseData['detail'] ??
                  "Sorry, couldn't register your account.",
              type: MessageType.error,
              duration: 1500);
        } else if (response.statusCode == 500) {
          showCustomFlushbar(
              context: context,
              message: "Server error. Please try again later.",
              type: MessageType.error,
              duration: 1500);
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
              duration: 1500);
        } else {
          showCustomFlushbar(
            context: context,
            message: "Something went wrong. Please try again later.",
            duration: 1500,
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
    final size = MediaQuery.of(context).size;
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Register Your Company!",
                style: GoogleFonts.openSans(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Please ensure all details provided are accurate. The admin will review your submission and approve your registration.",
                style: GoogleFonts.openSans(
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 12.5, fontWeight: FontWeight.w400),
                ),
              ),

              SizedBox(
                height: 16,
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                        backgroundImage: _selectedImage != null
                            ? FileImage(File(_selectedImage!.path))
                                as ImageProvider
                            : null,
                        child: _selectedImage == null
                            ? Icon(
                                Icons.camera_alt,
                                size: 28,
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Upload Company Profile Image",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextfield(
                      controller: _companyNameController,
                      labelText: 'Company Registered Name',
                      prefixIcon: CupertinoIcons.person_solid,
                      verticalContentPadding: 12,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Company name cannot be empty !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextfield(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.mail,
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter a valid company email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextfield(
                            controller: _phoneNumberController,
                            labelText: 'Phone',
                            prefixIcon: Icons.phone,
                            verticalContentPadding: 13.5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number cannot be empty !';
                              }
                              final onlyNumbersRegExp = RegExp(r'^[0-9-]+$');

                              if (!onlyNumbersRegExp.hasMatch(value)) {
                                return 'Please enter a valid phone number!';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MyTextfield(
                            controller: _addressController,
                            labelText: 'Address',
                            prefixIcon: Icons.location_on,
                            verticalContentPadding: 13.5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Address cannot be empty !';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextfield(
                      controller: _companyTypeController,
                      labelText: 'Company Type',
                      prefixIcon: Icons.business,
                      verticalContentPadding: 13.5,
                      hintText: "eg Software Company ",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Company type cannot be empty !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextfield(
                      controller: _registrationNumbeController,
                      labelText: 'Registration No.',
                      prefixIcon: Icons.business,
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Registration number cannot be empty !';
                        }
                        final onlyNumbersRegExp = RegExp(r'^[0-9]+$');

                        if (!onlyNumbersRegExp.hasMatch(value)) {
                          return 'Please enter a valid registration number!';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextfield(
                      controller: _panNumberController,
                      labelText: 'Pan No.',
                      prefixIcon: Icons.business,
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pan number cannot be empty !';
                        }
                        final onlyNumbersRegExp = RegExp(r'^[0-9]+$');
                        if (!onlyNumbersRegExp.hasMatch(value)) {
                          return 'Please enter a valid pan number!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyPasswordfield(
                      controller: _passwordController,
                      labelText: "Password",
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isTermsAndConditionAccepted,
                          onChanged: (value) {
                            setState(() {
                              isTermsAndConditionAccepted = value!;
                            });
                          },
                          activeColor: Colors.blue.shade600,
                        ),
                        Text(
                          "I agree to ",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          "Privacy Policy ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14),
                        ),
                        Text(
                          "and ",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                        Text(
                          "Terms of use ",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyButton(
                      color: Colors.blue,
                      width: size.width,
                      height: 44,
                      isLoading: _isLoading,
                      text: "Register Company",
                      onTap: _registerCompany,
                    ),
                  ],
                ),
              ),

              // MyButton(color: Colors.blue, size: size, text: "Sign In"),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text("Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.2,
                            color: Colors.blue,
                            letterSpacing: 0.5)),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
