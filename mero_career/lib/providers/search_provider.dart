import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/job_services.dart';

import '../services/auth_services.dart';
import '../services/job_seeker_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class SearchProvider extends ChangeNotifier {
  List<dynamic> _searchedData = [];
  bool _isLoading = false;

  List? get searchedData => _searchedData;

  bool get isLoading => _isLoading;

  final JobSeekerServices jobSeekerServices = JobSeekerServices();

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

  // to add to searched history
  Future<http.Response?> addToSearchHistory(
      BuildContext context, Map<String, dynamic> searchedData) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await jobSeekerServices.addToSearchHistory(searchedData);
      if (response.statusCode == 201) {
        getRecentSearchDetails();
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
      print(response.body);
      return response;
    } catch (e) {
      print("Error while adding searched details: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response?> removeFromSearchHistory(
      BuildContext context, int jobId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await jobSeekerServices.removeFromSearchHistory(jobId);

      if (response.statusCode == 204) {
        getRecentSearchDetails();
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
      return response;
    } catch (e) {
      print("Error while removing searched details: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // fetch all searched details
  Future<http.Response?> getRecentSearchDetails() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await jobSeekerServices.getRecentlySearchedData();

      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _searchedData = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while fetching recently searched details: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to clear all searched history
  Future<http.Response?> clearSearchHistory() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await jobSeekerServices.clearSearchedHistory();

      if (response.statusCode == 204) {
        getRecentSearchDetails();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error clearing searched details: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
