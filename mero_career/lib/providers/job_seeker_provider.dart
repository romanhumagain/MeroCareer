import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/providers/profile_setup_provider.dart';
import 'package:mero_career/services/job_seeker_services.dart';

import '../services/auth_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class JobSeekerProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _jobSeekerProfileDetails;
  Map<String, dynamic>? _careerPreference;

  // Public getters
  bool get isLoading => _isLoading;

  Map<String, dynamic>? get jobSeekerProfileDetails => _jobSeekerProfileDetails;

  Map<String, dynamic>? get careerPreference => _careerPreference;

  // Service instance
  final JobSeekerServices jobSeekerServices = JobSeekerServices();
  ProfileSetupProvider profileSetupProvider = ProfileSetupProvider();

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

  /// Fetch job seeker profile details
  Future<http.Response?> fetchJobSeekerProfileDetails() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await jobSeekerServices.fetchJobSeekerProfile();

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _jobSeekerProfileDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while fetching job seeker profile: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // update job seeker profile
  Future<void> updateJobSeekerProfileDetails(
      BuildContext context, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await jobSeekerServices.updateJobSeekerProfileDetails(updatedData);
      if (response.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully updated profile details",
            type: MessageType.success);
        await fetchJobSeekerProfileDetails();
        await profileSetupProvider.fetchProfileAnalysis();
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.pop(context);
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't update your profile !",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error updating profile !");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // fetch job seeker career preference
  Future<void> fetchCareerPreference(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await jobSeekerServices.fetchCareerPreference();
      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _careerPreference = responseData;
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Error fetching career preference !",
            type: MessageType.error);
      }
    } catch (e) {
      print("Error fetching career preference, $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // update job seeker career preference
  Future<void> updateCareerPreference(
      BuildContext context, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await jobSeekerServices.updateCareerPreference(updatedData);
      if (response.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully updated career preference",
            type: MessageType.success);
        fetchCareerPreference(context);
        await profileSetupProvider.fetchProfileAnalysis();
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 1500));
        Navigator.pop(context);
      } else if (response.statusCode == 400) {
        print("updatedData is ......... $updatedData");
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't update your career preference !",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error updating career preference !");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
