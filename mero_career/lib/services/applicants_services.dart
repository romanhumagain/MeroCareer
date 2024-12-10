import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';
import '../utils/auth_api_client.dart';

class ApplicantsServices {
  final AuthAPIClient _authAPIClient = AuthAPIClient();

  // to get all the list of recent applicants
  Future<http.Response> fetchAllRecentApplicants(String status) async {
    try {
      final response =
          await _authAPIClient.get('/recruiter/applicants/?status=$status');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch recent applicants $e');
    }
  }

  // to get all the list of active jobs along with applicants
  Future<http.Response> fetchActiveJobsWithApplicants(String jobStatus) async {
    try {
      final response = await _authAPIClient
          .get('/active-jobs-with-applicants/?status=$jobStatus');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch recent jobs with applicants $e');
    }
  }

  // to get applicants of selected job
  Future<http.Response> getSelectedJobApplicants(
      int jobId, String status) async {
    try {
      final response =
          await _authAPIClient.get('/jobs/$jobId/applicants/?status=$status');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch job applicants of selected job $e');
    }
  }

  // to get applicants of selected job
  Future<http.Response> getApplicantDetails(int applicantId) async {
    try {
      final response = await _authAPIClient.get('/applicants/$applicantId/');
      return response;
    } catch (e) {
      throw Exception(
          'Failed to fetch job applicants details of selected job $e');
    }
  }

  // update applicant details
  Future<http.Response> updateApplicantDetails(
      int applicantId, Map<String, dynamic> statusData) async {
    try {
      final response =
          await _authAPIClient.patch('/applicants/$applicantId/', statusData);
      return response;
    } catch (e) {
      throw Exception('Failed to update applicant application status $e');
    }
  }
}
