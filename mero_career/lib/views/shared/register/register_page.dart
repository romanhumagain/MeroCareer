import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_career/providers/theme_provider.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/register/recruiter_register_page.dart';
import 'package:mero_career/views/shared/register/user_verification_page.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:provider/provider.dart';

import '../../../models/job/job_category_model.dart';
import '../../../services/job_seeker_services.dart';
import '../../../services/job_services.dart';
import '../../widgets/validated_text_field.dart';
import '../login/login_page.dart';
import '../modal/show_job_category_modal.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late Future<List<JobCategory>> _jobCategories;
  bool isTermsAndConditionAccepted = false;

  @override
  void initState() {
    super.initState();
    _jobCategories = JobServices().getJobCategories();
  }

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _selectedCategory = "";
  String _selectedCategoryId = "";

  AuthServices authServices = AuthServices();

  void _registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedCategoryId == "") {
        showCustomFlushbar(
            context: context,
            message: "Please select your job preference !",
            type: MessageType.warning,
            duration: 1600);
      } else if (!isTermsAndConditionAccepted) {
        showCustomFlushbar(
            context: context,
            message: "Accept terms and condition before registering account.",
            type: MessageType.warning,
            duration: 1600);
      } else {
        setState(() {
          _isLoading = true;
        });

        final jobSeekerData = {
          'full_name':
              '${_firstNameController.text} ${_lastNameController.text}',
          'username': _usernameController.text,
          'email': _emailController.text,
          'phone_number': _phoneNumberController.text,
          'address': _locationController.text,
          'prefered_job_category': _selectedCategoryId,
          'password': _passwordController.text,
          'role': 'job_seeker'
        };

        try {
          JobSeekerServices jobSeekerServices = JobSeekerServices();
          final response = await jobSeekerServices.registerUser(jobSeekerData);

          final responseData = json.decode(response.body);

          if (response.statusCode == 201) {
            // final responseData = json.decode(response.body);
            await authServices.saveTokens(
                responseData['refresh'], responseData['access']);
            await authServices.saveUserRole(responseData['role']);
            await authServices
                .saveVerificationStatus(responseData['is_verified']);

            showCustomFlushbar(
                context: context,
                message:
                    "Successfully registered your account. Please verify your account now !",
                type: MessageType.success,
                duration: 1600);
            await Future.delayed(Duration(seconds: 2));
            _clearFields();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserVerificationPage()));
          } else if (response.statusCode == 400) {
            final responseData = json.decode(response.body);
            showCustomFlushbar(
                context: context,
                message: responseData['detail'] ??
                    "Sorry, couldn't register your account.",
                type: MessageType.error,
                duration: 1600);
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
                duration: 1500);
          }
        } catch (e) {
          if (e is SocketException) {
            showCustomFlushbar(
                context: context,
                message:
                    "No internet connection. Please check your connection.",
                type: MessageType.error,
                duration: 1500);
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
  }

  void _clearFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _locationController.clear();
    _passwordController.clear();

    setState(() {
      _selectedCategory = "";
      _selectedCategoryId = "";
    });
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
                "Lets Create Your Account",
                style: GoogleFonts.openSans(
                    textStyle: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ValidatedTextField(
                            controller: _firstNameController,
                            labelText: 'First Name',
                            prefixIcon: CupertinoIcons.person_solid,
                            verticalContentPadding: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name cannot be empty !';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ValidatedTextField(
                            controller: _lastNameController,
                            labelText: 'Last Name',
                            prefixIcon: CupertinoIcons.person_solid,
                            verticalContentPadding: 12,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last name cannot be empty !';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    ValidatedTextField(
                      controller: _usernameController,
                      labelText: 'Username',
                      prefixIcon: CupertinoIcons.person_add_solid,
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    ValidatedTextField(
                      controller: _emailController,
                      labelText: 'Email',
                      prefixIcon: Icons.mail,
                      verticalContentPadding: 13.5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ValidatedTextField(
                            controller: _phoneNumberController,
                            labelText: 'Phone',
                            prefixIcon: Icons.phone,
                            verticalContentPadding: 13.5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number cannot be empty !';
                              } else if (value.length != 10) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ValidatedTextField(
                            controller: _locationController,
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
                      height: 17,
                    ),
                    SelectContainer(
                      size: size,
                      isSelected: _selectedCategory == "" ? false : true,
                      selectText: _selectedCategory == ""
                          ? "Select Job Preference *"
                          : _selectedCategory,
                      onTap: () {
                        _showJobCategoryModal(context);
                      },
                    ),
                    SizedBox(
                      height: 17,
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
                      height: 17,
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
                      height: 12,
                    ),
                    MyButton(
                      color: Colors.blue,
                      width: size.width,
                      height: 44,
                      text: "Sign Up",
                      isLoading: _isLoading,
                      onTap: _registerUser,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterRegisterPage()));
                  },
                  child: Container(
                    width: size.width / 1.12,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: isDarkMode
                                ? Colors.grey.shade800
                                : Colors.grey.shade300)),
                    child: Center(
                        child: Text(
                      "Signup as Recruiter?",
                      style: TextStyle(fontSize: 17),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJobCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return JobCategoryModal(
          jobCategoriesFuture: _jobCategories,
          selectedCategory: _selectedCategory,
          onCategorySelected: (categoryName, categoryId) {
            setState(() {
              _selectedCategory = categoryName;
              _selectedCategoryId = categoryId;
            });
          },
        );
      },
    );
  }
}

class SelectContainer extends StatelessWidget {
  final String selectText;
  final Function onTap;
  final bool isSelected;
  final Size size;

  const SelectContainer({
    super.key,
    required this.selectText,
    required this.onTap,
    required this.isSelected,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade400 : null,
            border: !isSelected ? Border.all(color: Colors.grey) : null,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? Colors.white
                      : (isDarkMode
                          ? Colors.grey.shade300
                          : Colors.grey.shade900)),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.keyboard_arrow_down_outlined,
                size: 26,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode
                        ? Colors.grey.shade300
                        : Colors.grey.shade900))
          ],
        ),
      ),
    );
  }
}
