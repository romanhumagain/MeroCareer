import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/job_services.dart';

class JobProvider extends ChangeNotifier {
  List<dynamic> _postedJobLists = [];
  List<dynamic> _filterableJobLists = [];

  bool _isLoading = false;

  List? get postedJobLists => _postedJobLists;

  List? get filterableJobLists => _filterableJobLists;

  bool get isLoading => _isLoading;

  JobServices jobServices = JobServices();

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
        notifyListeners();
      }
      return response;
    } catch (e) {
      print('Error posting job: $e');
    }
    return null;
  }
}
