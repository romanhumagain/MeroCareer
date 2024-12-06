import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/recruiter_services.dart';

class RecruiterProvider extends ChangeNotifier {
  Map<String, dynamic>? _recruiterProfileDetails;
  bool _isLoading = false;

  Map<String, dynamic>? get recruiterProfileDetails => _recruiterProfileDetails;

  bool get isLoading => _isLoading;
  RecruiterServices recruiterServices = RecruiterServices();

// function to fetch recruiter profile details
  Future<void> fetchRecruiterProfile() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await recruiterServices.fetchRecruiterProfileDetails();

      if (response.statusCode == 200) {
        _recruiterProfileDetails = json.decode(response.body);
      } else {
        print('Failed to fetch recruiter profile: ${response.body}');
      }
    } catch (e) {
      print('Error fetching recruiter profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response?> updateRecruiterProfile(
      Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await recruiterServices.updateRecruiterProfile(updatedData);

      if (response.statusCode == 200) {
        await fetchRecruiterProfile();
      }
      return response;
    } catch (e) {
      print('Error updating recruiter profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }
}
