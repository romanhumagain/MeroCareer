import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/utils/auth_api_client.dart';

class JobSeekerServices {
  final String baseURL = 'http://10.0.2.2:8000/api';
  AuthAPIClient authAPIClient = AuthAPIClient();

  Future<http.Response> registerUser(Map<String, dynamic> jobSeekerData) async {
    try {
      final response = await http.post(
          Uri.parse('$baseURL/jobseeker/register/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(jobSeekerData));
      return response;
    } catch (e) {
      throw Exception('Error during job seeker registration $e');
    }
  }

// ======= function to fetch the job seeker profile details ============
  Future<http.Response> fetchJobSeekerProfile() async {
    final response = await authAPIClient.get('/jobseeker/');
    return response;
  }

// fetch every details of job seekers for profile preview
  Future<http.Response> fetchJobSeekerProfilePreview(int id) async {
    final response = await authAPIClient.get('/jobseeker-details/$id/');
    return response;
  }

// ======= function to update the job seeker profile details ==========
  Future<http.Response> updateJobSeekerProfileDetails(
      Map<String, dynamic> updatedData) async {
    final response = await authAPIClient.patch('/jobseeker/', updatedData);
    return response;
  }

// ====== function to fetch the career preference details ==========
  Future<http.Response> fetchCareerPreference() async {
    final response = await authAPIClient.get('/career-preference/');
    return response;
  }

// ======= function to update the career preference details ==========
  Future<http.Response> updateCareerPreference(
      Map<String, dynamic> updatedData) async {
    final response =
        await authAPIClient.patch('/career-preference/', updatedData);
    return response;
  }

// function to search the job
  Future<http.Response> addToSearchHistory(
      Map<String, dynamic> searchedData) async {
    final response = await authAPIClient.post('/recent-search/', searchedData);
    return response;
  }

// function to get all searched data
  Future<http.Response> getRecentlySearchedData() async {
    final response = await authAPIClient.get('/recent-search/');
    return response;
  }

  // function to remove the search history
  Future<http.Response> removeFromSearchHistory(int jobId) async {
    try {
      final response =
          await authAPIClient.delete('/remove-recent-search/$jobId/');
      return response;
    } catch (e) {
      throw Exception('Failed to remove search details $e');
    }
  }

// function to remove the search history
  Future<http.Response> clearSearchedHistory() async {
    try {
      final response = await authAPIClient.delete('/clear-all-search/');
      return response;
    } catch (e) {
      throw Exception('Failed to clear search $e');
    }
  }

  // function to remove the search history
  Future<http.Response> changeAccountPassword(
      Map<String, dynamic> credentialsData) async {
    try {
      final response =
          await authAPIClient.post('/change-password/', credentialsData);
      return response;
    } catch (e) {
      throw Exception('Failed to clear search $e');
    }
  }

  // function to remove the search history
  Future<http.Response> deactivateAccount(
      Map<String, dynamic> credentialsData) async {
    try {
      final response =
          await authAPIClient.post('/deactivate-account/', credentialsData);
      return response;
    } catch (e) {
      throw Exception('Failed to deactivate account $e');
    }
  }
}
