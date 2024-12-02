import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/register/user_verification_page.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:mero_career/views/widgets/my_passwordfield.dart';
import 'package:mero_career/views/widgets/my_textfield.dart';

import '../../job_seekers/common/modal_top_bar.dart';
import '../login/login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final List<Map<String, dynamic>> _categoryList = [
    {"id": 1, "categoryName": "IT & Telecommunication"},
    {"id": 2, "categoryName": "Architecture & Design"},
    {"id": 3, "categoryName": "Teaching & Education"},
    {"id": 4, "categoryName": "Hospital"},
    {"id": 5, "categoryName": "Banking & Insurance"},
    {"id": 6, "categoryName": "Graphic Designing"},
    {"id": 7, "categoryName": "Accounting"},
    {"id": 8, "categoryName": "Construction"},
    {"id": 9, "categoryName": "Others"},
  ];

  String _selectedCategory = "";
  String _selectedCategoryId = "";

  void _registerUser() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserVerificationPage()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0),
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
                    width: 10,
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
              Row(
                children: [
                  Expanded(
                    child: MyTextfield(
                      controller: _phoneNumberController,
                      labelText: 'Phone',
                      prefixIcon: Icons.phone,
                      verticalContentPadding: 13.5,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyTextfield(
                      controller: _locationController,
                      labelText: 'Address',
                      prefixIcon: Icons.location_on,
                      verticalContentPadding: 13.5,
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
                  _showJobCategoryModalSheet(context);
                },
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
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                  Text(
                    "Privacy Policy ",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                text: "Sign Up",
                onTap: _registerUser,
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
                height: 15,
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

  void _showJobCategoryModalSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: size.height / 1.8,
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF121212) : Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                ModalTopBar(),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Preferred Job Category",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18.5),
                      ),
                      _selectedCategory == ""
                          ? Text("")
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = "";
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Clear",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.blue)),
                            ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: _categoryList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory =
                                  _categoryList[index]['categoryName'];
                              _selectedCategoryId =
                                  _categoryList[index]['id'].toString();
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              _categoryList[index]['categoryName'],
                              style: TextStyle(fontSize: 16.4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
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
