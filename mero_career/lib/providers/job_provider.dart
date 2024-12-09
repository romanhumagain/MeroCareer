import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/applicants_services.dart';
import 'package:mero_career/services/job_services.dart';
import 'package:mero_career/services/recruiter_services.dart';

class JobProvider extends ChangeNotifier {
  List<dynamic> _postedJobLists = [];
  List<dynamic> _filterableJobLists = [];
  Map<String, dynamic>? _recruiterStats = {};
  List<dynamic> _recentApplicants = [];
  List<dynamic> _selectedJobApplicants = [];
  List<dynamic> _activeJobWithApplicants = [];

  bool _isLoading = false;

  List? get postedJobLists => _postedJobLists;

  List? get filterableJobLists => _filterableJobLists;

  List? get recentApplicants => _recentApplicants;

  List? get selectedJobApplicants => _selectedJobApplicants;

  List? get activeJobWithApplicants => _activeJobWithApplicants;

  bool get isLoading => _isLoading;

  Map<String, dynamic>? get recruiterStats => _recruiterStats;

  JobServices jobServices = JobServices();
  ApplicantsServices applicantsServices = ApplicantsServices();
  RecruiterServices recruiterServices = RecruiterServices();

  Future<http.Response?> getJobPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await jobServices.fetchJobPosts();
      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _postedJobLists = responseData;
        notifyListeners();
        print(
            'Job posts updated: $_postedJobLists'); // Add this line for debugging
      }
      return response;
    } catch (e) {
      print("Failed to fetch the job posts $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<http.Response?> getFilterableJobPosts(
      {String filter_by = "all"}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await jobServices.fetchJobPosts(filer_by: filter_by);

      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _filterableJobLists = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Failed to fetch the job posts $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<http.Response?> postJob(Map<String, dynamic> jobData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await jobServices.postJob(jobData);
      if (response.statusCode == 201) {
        await getJobPosts();
        await getRecruiterStats();
        // await getFilterableJobPosts();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print('Error posting job: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<http.Response?> updateJob(
      int id, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await jobServices.updateJobPost(id, updatedData);
      if (response.statusCode == 200) {
        await getJobPosts();
        await getFilterableJobPosts();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print('Error posting job: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<http.Response?> deleteJobPost(int id) async {
    try {
      final response = await jobServices.deleteJobPost(id);
      print(response.body);

      if (response.statusCode == 200) {
        await getFilterableJobPosts();
        await getJobPosts();
        await getRecruiterStats();
        notifyListeners();
      }
      return response;
    } catch (e) {
      print('Error posting job: $e');
    }
    return null;
  }

  // function to fetch recruiter profile details
  Future<void> getRecruiterStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await recruiterServices.getRecruiterStats();

      if (response.statusCode == 200) {
        _recruiterStats = json.decode(response.body);
        notifyListeners();
      } else {
        print('Failed to fetch recruiter stata: ${response.body}');
      }
    } catch (e) {
      print('Error fetching recruiter stats: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch all recent  applicants
  Future<void> getRecentApplicants(String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await applicantsServices.fetchAllRecentApplicants(status);

      if (response.statusCode == 200) {
        _recentApplicants = json.decode(response.body);
        notifyListeners();
      } else {
        print('Failed to fetch recent applicants: ${response.body}');
      }
    } catch (e) {
      print('Error fetching recent applicants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch all active job with applicants
  Future<void> getActiveJobWithApplicants(String jobStatus) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await applicantsServices.fetchActiveJobsWithApplicants(jobStatus);

      if (response.statusCode == 200) {
        _activeJobWithApplicants = json.decode(response.body);
        notifyListeners();
      } else {
        print('Failed to fetch active job with applicants: ${response.body}');
      }
    } catch (e) {
      print('Error fetching active job with applicants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch all active job with applicants
  Future<void> fetchSelectedJobApplicants(int jobId, String status) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await applicantsServices.getSelectedJobApplicants(jobId, status);

      if (response.statusCode == 200) {
        _selectedJobApplicants = json.decode(response.body);
        notifyListeners();
      } else {
        print('Failed to fetch selected job with applicants: ${response.body}');
      }
    } catch (e) {
      print('Error fetching selected job with applicants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
