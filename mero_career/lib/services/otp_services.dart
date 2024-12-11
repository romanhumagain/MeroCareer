import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class OtpServices {
  // to post the job
  final AuthAPIClient _authAPIClient = AuthAPIClient();

  // function to send otp verification code
  Future<http.Response?> sendOTP() async {
    try {
      final response = await _authAPIClient.get('/send-otp/');
      return response;
    } catch (e) {
      print("Error sending OTP: $e");
      return null;
    }
  }

  // function to send otp verification code
  Future<http.Response?> verifyOTP(String otp) async {
    try {
      final response = await _authAPIClient.put('/verify-otp/$otp/', {});
      return response;
    } catch (e) {
      print("Error verrifying OTP: $e");
      return null;
    }
  }
}
