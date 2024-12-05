import 'package:http/http.dart' as http;
import 'package:mero_career/utils/api_client.dart';
import 'package:mero_career/utils/api_config.dart';
import 'package:mero_career/utils/auth_api_client.dart';

class RecruiterServices {
  final baseUrl = baseURL;

// to post the job
  final AuthAPIClient authAPIClient = AuthAPIClient();

  // ===== function to register recruiter
  Future<http.Response> registerRecruiter(
      Map<String, dynamic> recruiterData) async {
    ApiClient apiClient = ApiClient();
    final response =
        await apiClient.post('/recruiter/register/', recruiterData);
    return response;
  }

  // function to handle fetching recruiter details
  Future<http.Response> fetchRecruiterProfileDetails() async {
    final response = await authAPIClient.get('/recruiter/');
    return response;
  }

  // function to update recruiter profile
  Future<http.Response> updateRecruiterProfile(
      Map<String, dynamic> updatedData) async {
    final response = await authAPIClient.patch('/recruiter/', updatedData);
    return response;
  }
}
