import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class JobSeekerJobServices {
  Future<List<JobCategory>> getJobCategories() async {
    const String baseUrl = baseURL;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/jobs-category/'),
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

  // to fetch the job based on the category
  Future<http.Response> fetchJobByCategory(
      int categoryId, String filter_by) async {
    final response = await _authAPIClient
        .get('/jobs/category/$categoryId/?status=$filter_by');
    return response;
  }

  // function to fetch the job based on the organization
  Future<http.Response> fetchJobByOrganization() async {
    final response = await _authAPIClient.get('/jobs/organization/');
    return response;
  }

  // function to get the recruiter info along with posted jobs
  Future<http.Response> getRecruiterInfo(int recruiterId) async {
    final response = await _authAPIClient.get('/recruiter/job/$recruiterId/');
    return response;
  }

  // to get all the list of posted job
  Future<http.Response> fetchJobPosts(
      {required int recruiterId, String filer_by = "all"}) async {
    try {
      final response = await _authAPIClient
          .get('/joblist/$recruiterId/?filter_by=$filer_by');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch posts $e');
    }
  }

  // function to fetch the matched job
  Future<http.Response> fetchMatchedJob() async {
    final response = await _authAPIClient.get('/matched/jobs/');
    return response;
  }

  // function to fetch the expiring jobs
  Future<http.Response> fetchExpiringJob() async {
    final response = await _authAPIClient.get('/jobs/expiring-soon/');
    return response;
  }

  // function to fetch all active jobs
  Future<http.Response> fetchAllActiveJob() async {
    final response = await _authAPIClient.get('/active/jobs/');
    return response;
  }

  // function to get details of selected job
  Future<http.Response> getJobDetails(int jobId) async {
    final response = await _authAPIClient.get('/get-job-details/$jobId/');
    return response;
  }

  // function to save job
  Future<http.Response> saveJob(Map<String, dynamic> jobData) async {
    final response = await _authAPIClient.post('/save-job/', jobData);
    return response;
  }

  // function to unsave job
  Future<http.Response> unSaveJob(int jobId) async {
    final response = await _authAPIClient.delete('/unsave-job/$jobId/');
    return response;
  }

  // function to get saved posts
  Future<http.Response> getSavedPosts(bool includeClosed) async {
    final response =
        await _authAPIClient.get('/saved-post/?include_closed=$includeClosed');
    return response;
  }

  Future<http.Response> filterJob({
    required String job_title,
    required String job_level,
    required int? experience,
    required String job_type,
    required String category_name,
  }) async {
    String query = '?';

    if (job_title.isNotEmpty && job_title != "All") {
      query += 'job_title=$job_title&';
    }
    if (job_level.isNotEmpty && job_level != "All") {
      query += 'job_level=$job_level&';
    }
    if (experience != null && experience > 0) {
      query += 'experience=$experience&';
    }
    if (job_type.isNotEmpty && job_type != "All") {
      query += 'job_type=$job_type&';
    }
    if (category_name.isNotEmpty && category_name != "All") {
      query += 'category=$category_name&';
    }

    if (query.endsWith('&')) {
      query = query.substring(0, query.length - 1);
    }

    final response = await _authAPIClient.get('/job/$query');

    return response;
  }

// Function to apply to the job posts
  Future<http.Response> applyForJob(Map<String, dynamic> jobData) async {
    final response = await _authAPIClient.post('/application/', jobData);
    return response;
  }

  // function to get all applied jobs
  Future<http.Response> getAppliedJobs(String status) async {
    final response = await _authAPIClient.get('/application/?status=$status');
    return response;
  }

  // function to cancel job application
  Future<http.Response> cancelJobApplication(int jobId) async {
    final response = await _authAPIClient.delete('/application/$jobId/');
    return response;
  }
}
