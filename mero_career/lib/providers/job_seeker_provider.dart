import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/services/notification_services.dart';

import '../services/auth_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class JobSeekerProvider extends ChangeNotifier {
  bool _isLoading = false;

  Map<String, dynamic>? _notificationDetails = {};
  List<dynamic>? _unreadNotification = [];
  Map<String, dynamic>? _accountSettings = {};

  // Public getters
  bool get isLoading => _isLoading;

  Map<String, dynamic>? get accountSettings => _accountSettings;

  Map<String, dynamic>? get notificationDetails => _notificationDetails;

  List<dynamic>? get unreadNotification => _unreadNotification;

  // Service instance
  final JobSeekerServices jobSeekerServices = JobSeekerServices();
  ProfileSetupProvider profileSetupProvider = ProfileSetupProvider();
  NotificationServices notificationServices = NotificationServices();

  void handleLogoutUser(BuildContext context) async {
    AuthServices authServices = AuthServices();
    await authServices.logoutUser();
    showCustomFlushbar(
        context: context,
        message: "Session expired ! Please login again",
        type: MessageType.error);
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  // to fetch notifications for job seeker
  Future<http.Response?> fetchNotifications() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await notificationServices.fetchNotification();

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _notificationDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while fetching notification: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to fetch all unread notification
  Future<http.Response?> getAllUnreadNotification() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await notificationServices.getUnreadNotification();

      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _unreadNotification = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while getting unread notification $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to fetch notifications for job seeker
  Future<http.Response?> markAllNotificationRead() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await notificationServices.markAllNotificationRead();
      if (response.statusCode == 200) {
        getAllUnreadNotification();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while making all notification read $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to fetch all unread notification
  Future<http.Response?> getAccountSettings() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await notificationServices.getAccuntSettings();

      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _accountSettings = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while getting account settings $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to fetch all unread notification
  Future<http.Response?> updateAccountSettings(
      Map<String, bool> settingsData) async {
    try {
      final response =
          await notificationServices.updateAccountSettings(settingsData);

      if (response.statusCode == 200) {
        getAccountSettings();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while upadating account settings $e");
      return null;
    } finally {}
  }
}
