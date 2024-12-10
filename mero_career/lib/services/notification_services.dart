import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class NotificationServices {
  // to post the job
  final AuthAPIClient _authAPIClient = AuthAPIClient();

  // to get list of notification
  Future<http.Response> fetchNotification() async {
    try {
      final response = await _authAPIClient.get('/notifications/');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch notifications $e');
    }
  }

  // to get list of unread notification
  Future<http.Response> getUnreadNotification() async {
    try {
      final response = await _authAPIClient.get('/notifications/unread/');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch unread notifications $e');
    }
  }

  // to get list of unread notification
  Future<http.Response> markAllNotificationRead() async {
    try {
      final response =
          await _authAPIClient.post('/notifications/mark-all-read/', {});
      return response;
    } catch (e) {
      throw Exception('Failed to mark all notification read notifications $e');
    }
  }

  Future<http.Response> getAccuntSettings() async {
    try {
      final response = await _authAPIClient.get('/account/settings/');
      return response;
    } catch (e) {
      throw Exception('Failed to get account settings $e');
    }
  }

  Future<http.Response> updateAccountSettings(
      Map<String, bool> settingsData) async {
    try {
      final response = await _authAPIClient.patch('/settings/', settingsData);
      return response;
    } catch (e) {
      throw Exception('Failed update account settings $e');
    }
  }
}
