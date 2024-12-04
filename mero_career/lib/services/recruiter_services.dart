import 'package:http/http.dart' as http;
import 'package:mero_career/utils/api_client.dart';
import 'dart:convert';
import 'package:mero_career/utils/api_config.dart';

class RecruiterServices{
  final baseUrl = baseURL;

  // ===== function to register recruiter
  Future<http.Response> registerRecruiter(Map<String, dynamic> recruiterData) async{
    ApiClient apiClient = ApiClient();
    final response = apiClient.post('/recruiter/register/', recruiterData);
    return response;
  }

}