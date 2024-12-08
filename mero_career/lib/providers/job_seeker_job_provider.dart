import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/job_seeker_job_services.dart';
import 'package:mero_career/services/job_services.dart';

import '../services/auth_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class JobSeekerJobProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<dynamic>? _matchedJobs;
  List<dynamic>? _expiringJobs;
  List<dynamic>? _allActiveJobs;
  Map<String, dynamic>? _jobDetails;
  List<dynamic>? _savedPosts;

  List<dynamic>? get matchedJobs => _matchedJobs;

  List<dynamic>? get expiringJobs => _expiringJobs;

  List<dynamic>? get allActiveJobs => _allActiveJobs;

  List<dynamic>? get savedPosts => _savedPosts;

  Map<String, dynamic>? get jobDetails => _jobDetails;

  bool get isLoading => _isLoading;
  JobSeekerJobServices jobServices = JobSeekerJobServices();

  // to handle logout
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

  // function to fetch the matched job
  Future<http.Response?> fetchMatchedJob() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.fetchMatchedJob();
      if (response.statusCode == 200) {
        _matchedJobs = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching job lists $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response?> fetchExipringJobs() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.fetchExpiringJob();
      if (response.statusCode == 200) {
        _expiringJobs = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching job lists $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response?> fetchAllActiveJobs() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.fetchAllActiveJob();
      if (response.statusCode == 200) {
        _allActiveJobs = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching job lists $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<http.Response?> getJobDetails(int jobId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.getJobDetails(jobId);
      if (response.statusCode == 200) {
        _jobDetails = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching job details $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to save job
  Future<http.Response?> saveJob(
      BuildContext context, Map<String, dynamic> jobData) async {
    try {
      final response = await jobServices.saveJob(jobData);
      if (response.statusCode == 201) {
        fetchMatchedJob();
        fetchAllActiveJobs();
        fetchExipringJobs();
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't Saved Job. Please try again !",
            type: MessageType.error);
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error saving job $e");
      return null;
    }
  }

  // function to save job
  Future<http.Response?> unSaveJob(BuildContext context, int jobId) async {
    try {
      final response = await jobServices.unSaveJob(jobId);
      if (response.statusCode == 204) {
        fetchMatchedJob();
        fetchAllActiveJobs();
        fetchExipringJobs();
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't Unsaved Job. Please try again !",
            type: MessageType.error);
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error unsaving job  $e");
      return null;
    }
  }

  Future<http.Response?> getSavedPosts(bool includeClosed) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.getSavedPosts(includeClosed);
      if (response.statusCode == 200) {
        _savedPosts = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching saved job posts details $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
