import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/utils/api_config.dart';

import '../services/auth_services.dart';

class AuthAPIClient {
  final baseUrl = baseURL;
  AuthServices authServices = AuthServices();

  // Function to check if the access token is valid
  Future<bool> _isAccessTokenValid() async {
    return await authServices.isLoggedIn();
  }

  // Function to handle refreshing the access token
  Future<void> _refreshAccessToken() async {
    await authServices.refreshAccessToken();
  }

  // Main POST method to handle both token validation and requests
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    String? accessToken = await authServices.getAccessToken();

    // Check if the access token is valid
    if (accessToken != null && !await _isAccessTokenValid()) {
      // If access token is invalid, refresh it
      await _refreshAccessToken();
      // Get the new access token after refresh
      accessToken = await authServices.getAccessToken();

      if (accessToken == null) {
        // If the refresh token is also invalid or expired, return 401
        return http.Response('Unauthorized', 401);
      }
    }

    // Make the POST request with the valid access token
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(body),
    );
    return response;
  }

  // Main GET method to handle both token validation and requests
  Future<http.Response> get(String endpoint) async {
    String? accessToken = await authServices.getAccessToken();
    // Check if the access token is valid
    if (accessToken != null && !await _isAccessTokenValid()) {
      // If access token is invalid, refresh it
      await _refreshAccessToken();
      // Get the new access token after refresh
      accessToken = await authServices.getAccessToken();
      if (accessToken == null) {
        return http.Response('Unauthorized', 401);
      }
    }
    // Make the GET request with the valid access token
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    return response;
  }

  // Main put method to update complete data
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    String? accessToken = await authServices.getAccessToken();

    if (accessToken != null && !await _isAccessTokenValid()) {
      // Refresh the access token
      await _refreshAccessToken();
      accessToken = await authServices.getAccessToken();

      if (accessToken == null) {
        return http.Response('Unauthorized', 401);
      }
    }
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(body),
    );
    return response;
  }

// Main patch method to update data partially
  Future<http.Response> patch(
      String endpoint, Map<String, dynamic> body) async {
    String? accessToken = await authServices.getAccessToken();

    if (accessToken != null && !await _isAccessTokenValid()) {
      // Refresh the access token
      await _refreshAccessToken();
      accessToken = await authServices.getAccessToken();

      if (accessToken == null) {
        return http.Response('Unauthorized', 401);
      }
    }
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(body),
    );
    return response;
  }

// Main delete methid to delete the data
  Future<http.Response> delete(String endpoint) async {
    String? accessToken = await authServices.getAccessToken();

    // Check if the access token is valid
    if (accessToken != null && !await _isAccessTokenValid()) {
      await _refreshAccessToken();
      accessToken = await authServices.getAccessToken();

      if (accessToken == null) {
        return http.Response('Unauthorized', 401);
      }
    }
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }
}
