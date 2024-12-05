import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class JobServices {
  Future<List<JobCategory>> getJobCategories() async {
    const String baseUrl = baseURL;

    try {
      final response = await http.get(
        Uri.parse('${baseUrl}/jobs-category/'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => JobCategory.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load job categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching job categories: $e');
    }
  }

  // to post the job
  final AuthAPIClient _authAPIClient = AuthAPIClient();

  Future<http.Response> postJob(Map<String, dynamic> jobData) async {
    try {
      final response = await _authAPIClient.post("/jobs/", jobData);
      return response;
    } catch (e) {
      throw Exception('Failed to post job: $e');
    }
  }

  // to get all the list of posted job
  Future<http.Response> fetchJobPosts({String filer_by = "all"}) async {
    try {
      final response = await _authAPIClient.get('/jobs/?filter_by=$filer_by');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts $e');
    }
  }

  // to retrive the selected job details
  Future<http.Response> fetchJobDetails(int id) async {
    try {
      final response = await _authAPIClient.get('/jobs/$id');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts $e');
    }
  }

  Future<http.Response> deleteJobPost(int id) async {
    try {
      final response = await _authAPIClient.delete('/jobs/$id/');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts $e');
    }
  }

  Future<http.Response> updateJobPost(
      int id, Map<String, dynamic> updatedData) async {
    try {
      final response = await _authAPIClient.patch('/jobs/$id/', updatedData);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts $e');
    }
  }
}
