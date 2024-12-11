import 'package:flutter/material.dart';
import 'package:mero_career/main.dart';
import 'package:mero_career/services/auth_services.dart';
import 'package:mero_career/services/otp_services.dart';
import 'package:mero_career/views/job_seekers/common/app_bar.dart';
import 'package:mero_career/views/shared/register/under_approval_page.dart';
import 'package:mero_career/views/widgets/custom_flushbar_message.dart';
import 'package:mero_career/views/widgets/my_button.dart';
import 'package:provider/provider.dart';

import '../../../providers/job_seeker_provider.dart';
import '../../../providers/recruiter_provider.dart';
import '../../job_seekers/common/main_screen.dart';
import '../../recruiters/common/recruiter_main_screen.dart';

class UserVerificationPage extends StatefulWidget {
  const UserVerificationPage({super.key});

  @override
  State<UserVerificationPage> createState() => _UserVerificationPageState();
}

class _UserVerificationPageState extends State<UserVerificationPage> {
  final TextEditingController _firstDigitController = TextEditingController();
  final TextEditingController _secondDigitController = TextEditingController();
  final TextEditingController _thirdDigitController = TextEditingController();
  final TextEditingController _fourthDigitController = TextEditingController();

  AuthServices authServices = AuthServices();
  OtpServices otpServices = OtpServices();

  String userRole = "";
  bool isOTPSent = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserRole();
  }

  void clearFields() {
    _firstDigitController.clear();
    _secondDigitController.clear();
    _thirdDigitController.clear();
    _fourthDigitController.clear();
  }

  void _fetchUserRole() async {
    try {
      final role = await authServices.getUserRole();
      setState(() {
        userRole = role ?? '';
      });
    } catch (e) {
      setState(() {
        userRole = '';
      });
      print("Error fetching user role: $e");
    }
  }

  void sendOTP() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await otpServices.sendOTP();
      if (response?.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully sent OTP to your email.",
            type: MessageType.success,
            duration: 1500);
        setState(() {
          isOTPSent = true;
        });
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't send OTP to your email !",
            type: MessageType.error,
            duration: 1500);
      }
    } catch (e) {
      showCustomFlushbar(
          context: context,
          message: "Couldn't send OTP to your email !",
          type: MessageType.error,
          duration: 1500);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void reSendOTP() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await otpServices.sendOTP();
      if (response?.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully sent OTP. Please check your email !",
            type: MessageType.success,
            duration: 1200);
        clearFields();
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't resend OTP to your email !",
            type: MessageType.error,
            duration: 1500);
      }
    } catch (e) {
      showCustomFlushbar(
          context: context,
          message: "Couldn't resend OTP to your email !",
          type: MessageType.error,
          duration: 1500);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void verifyOTP() async {
    try {
      setState(() {
        isLoading = true;
      });
      final String otp =
          "${_firstDigitController.text}${_secondDigitController.text}${_thirdDigitController.text}${_fourthDigitController.text}";

      if (otp.length < 4) {
        showCustomFlushbar(
            context: context,
            duration: 1200,
            message: "Please provide 4 digits OTP Code !",
            type: MessageType.error);
        return;
      }
      final response = await otpServices.verifyOTP(otp);
      if (response?.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully Verified OTP !",
            type: MessageType.success,
            duration: 1600);

        clearFields();
        await authServices.saveVerificationStatus(true);

        await Future.delayed(Duration(seconds: 2));

        if (userRole == 'job_seeker') {
          await Provider.of<JobSeekerProvider>(context, listen: false)
              .fetchJobSeekerProfileDetails();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        isLoggedInNow: true,
                      )),
              (route) => false);
        } else if (userRole == "recruiter") {
          bool? isApproved = await authServices.getRecruiterApprovalStatus();
          if (isApproved!) {
            await Provider.of<RecruiterProvider>(context, listen: false)
                .fetchRecruiterProfile();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => RecruiterMainScreen(
                          isLoggedInNow: true,
                        )),
                (route) => false);
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UnderApprovalPage()));
          }
        }
      } else if (response?.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "OTP expired! Please resend again.",
            type: MessageType.error,
            duration: 1500);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Invalid OTP! Please try again",
            type: MessageType.error,
            duration: 1500);
      }
    } catch (e) {
      showCustomFlushbar(
          context: context,
          message: "Couldn't send OTP to your email !",
          type: MessageType.error,
          duration: 1500);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      body: !isOTPSent
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Verify Your Account",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We will sent a 4-digit OTP code to your registered email. Please check your email.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  userRole == "recruiter"
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Your verified account will be reviewed by the admin and approved. After this, you can access your account!",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(fontSize: 13),
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(height: 24),
                  MyButton(
                    color: Colors.blue,
                    width: 180,
                    height: 45,
                    text: "Send OTP",
                    isLoading: isLoading,
                    onTap: () {
                      isLoading ? () {} : sendOTP();
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Didn’t receive the OTP? Check your spam folder or try resending.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 27.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    "Enter the 4-digit verification code sent to your email.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Please check your inbox and enter the code below.",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                  const SizedBox(height: 40),

                  // Submit Button
                  Center(
                    child: MyButton(
                      color: Colors.blue.shade600,
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45,
                      isLoading: isLoading,
                      onTap: () {
                        isLoading ? () {} : verifyOTP();
                      },
                      text: "Verify Code",
                    ),
                  ),

                  // Resend code option
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                      ),
                      GestureDetector(
                        onTap: () {
                          reSendOTP();
                        },
                        child: Text(
                          "Resend",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // Function to build a single input box for each digit
  Widget _buildCodeBox({required TextEditingController controller}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          hintText: '',
        ),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
