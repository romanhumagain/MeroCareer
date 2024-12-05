import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_client.dart';

class AuthServices {
  static const String baseURL = 'http://10.0.2.2:8000/api';

  // to save token in the shared preference
  Future<void> saveTokens(String refreshToken, String accessToken) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('refreshToken', refreshToken);
    await preferences.setString('accessToken', accessToken);
  }

  Future<void> saveUserRole(String role) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString("userRole", role);
  }

  Future<void> saveVerificationStatus(bool isVerified) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool("isVerified", isVerified);
  }

  // to get access token
  Future<String?> getAccessToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('accessToken');
  }

  // to get refresh token
  Future<String?> getRefreshToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('refreshToken');
  }

  // to get the user role
  Future<String?> getUserRole() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('userRole');
  }

  // to get user verification status
  Future<bool?> getUserVerificationStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isVerified');
  }

  // to clear tokens or to logout
  Future<void> logoutUser() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('refreshToken');
    await preferences.remove('accessToken');
    await preferences.remove('userRole');
  }

  // to check whether the token is valid or not and user is loggedin or not
  Future<bool> isLoggedIn() async {
    String? token = await getAccessToken();
    if (token != null && !JwtDecoder.isExpired(token)) {
      return true;
    } else {
      return false;
    }
  }

  // to refresh the access token through accesstoken
  Future<void> refreshAccessToken() async {
    const url = "${baseURL}/token/refresh/";
    final refreshToken = await getRefreshToken();

    if (refreshToken != null) {
      try {
        final response = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'refresh': refreshToken}));

        if (response.statusCode == 200) {
          final responseData = await jsonDecode(response.body);

          await saveTokens(responseData['refresh'], responseData['access']);
        } else if (response.statusCode == 401) {
          logoutUser();
        } else {
          throw Exception("Failed to refresh token: ${response.body}");
        }
      } catch (e) {
        throw Exception('Error refreshing token: $e');
      }
    } else {
      throw Exception("Token not found");
    }
  }

  // to handle the login
  Future<http.Response> loginUser(Map<String, dynamic> loginCredentials) async {
    ApiClient apiClient = ApiClient();
    final response = apiClient.post('/user/login/', loginCredentials);
    return response;
  }
}
