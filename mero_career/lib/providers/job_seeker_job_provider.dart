import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/providers/job_seeker_provider.dart';
import 'package:mero_career/services/job_seeker_job_services.dart';
import 'package:mero_career/services/job_seeker_services.dart';
import 'package:mero_career/services/job_services.dart';

import '../services/auth_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class JobSeekerJobProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<dynamic>? _matchedJobs = [];
  List<dynamic>? _expiringJobs = [];
  List<dynamic>? _allActiveJobs = [];
  Map<String, dynamic>? _jobDetails = {};
  List<dynamic>? _savedPosts = [];
  List<dynamic>? _appliedJobs = [];
  Map<String, dynamic>? _appliedJobCount = {};

  List<dynamic>? get matchedJobs => _matchedJobs;

  List<dynamic>? get expiringJobs => _expiringJobs;

  List<dynamic>? get allActiveJobs => _allActiveJobs;

  List<dynamic>? get savedPosts => _savedPosts;

  List<dynamic>? get appliedJobs => _appliedJobs;

  Map<String, dynamic>? get jobDetails => _jobDetails;

  Map<String, dynamic>? get appliedJobCount => _appliedJobCount;

  bool get isLoading => _isLoading;
  JobSeekerJobServices jobServices = JobSeekerJobServices();
  JobSeekerServices services = JobSeekerServices();

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

  // function to get applied jobs count in profile heading
  Future<http.Response?> getAppliedJobCount() async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await services.fetchJobSeekerProfile();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _appliedJobCount?.addAll({
          'applied_job': responseData['applied_job'],
          'application_under_review': responseData['application_under_review']
        });
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

  // function to apply jobs
  Future<http.Response?> getAppliedJobs(String status) async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await jobServices.getAppliedJobs(status);
      if (response.statusCode == 200) {
        _appliedJobs = json.decode(response.body);
        notifyListeners();
      } else {
        print(response.body);
      }
      return response;
    } catch (e) {
      print("Error fetching applied job lists $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to apply for jobs
  Future<http.Response?> applyForJob(
      BuildContext context, Map<String, dynamic> jobData) async {
    try {
      final response = await jobServices.applyForJob(jobData);
      if (response.statusCode == 201) {
        getJobDetails(jobData['job']);
        getAppliedJobCount();
        notifyListeners();

        showCustomFlushbar(
            context: context,
            message: "Successfully Applied for Job",
            type: MessageType.success);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't Apply for Job. Please try again !",
            type: MessageType.error);
      }
      print(response.body);
      return response;
    } catch (e) {
      print("Error applying job $e");
      return null;
    }
  }

  // function to cancel job applications
  Future<http.Response?> cancelJobApplication(
      BuildContext context, int jobId) async {
    try {
      final response = await jobServices.cancelJobApplication(jobId);
      if (response.statusCode == 204) {
        getJobDetails(jobId);
        getAppliedJobCount();
        notifyListeners();
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      } else {
        showCustomFlushbar(
            context: context,
            message: "Couldn't Cancel Job Application. Please try again !",
            type: MessageType.error);
      }
      return response;
    } catch (e) {
      print("Error canceling job application  $e");
      return null;
    }
  }
}
