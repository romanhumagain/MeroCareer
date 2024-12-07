import 'package:http/http.dart' as http;
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class ProfileSetupServices {
  final String baseUrl = baseURL;
  AuthAPIClient authAPIClient = AuthAPIClient();

  // function to get the profile setup analysis
  Future<http.Response> getProfileSetupAnalysis() async {
    final response = await authAPIClient.get('/profile-setup-analysis/');
    return response;
  }

  // function to get the skills details
  Future<http.Response> getSkillsDetails() async {
    final response = await authAPIClient.get('/skill/');
    return response;
  }

  // function to add/update skills
  Future<http.Response> updateSkills(Map<String, dynamic> skillsData) async {
    final response = await authAPIClient.put('/skill/', skillsData);
    return response;
  }

  // function to get the education details
  Future<http.Response> getEducationDetails() async {
    final response = await authAPIClient.get('/education-details/');
    return response;
  }

  // function to add education details
  Future<http.Response> addEducationDetails(
      Map<String, dynamic> educationData) async {
    final response =
        await authAPIClient.post('/education-details/', educationData);
    return response;
  }

  // function to update education details
  Future<http.Response> updateEducationDetails(
      Map<String, dynamic> educationData, int id) async {
    final response =
        await authAPIClient.put('/education-details/$id/', educationData);
    return response;
  }

  // function to delete the education details
  Future<http.Response> deleteEducationDetails(int id) async {
    final response = await authAPIClient.delete('/education-details/$id/');
    return response;
  }

  // ---------------------------- E X P E R I E N C E ----------------------

  // function to get experience details
  Future<http.Response> getExperienceDetails() async {
    final response = await authAPIClient.get('/experience-details/');
    return response;
  }

  // function to add experience details
  Future<http.Response> addExperienceDetails(
      Map<String, dynamic> experienceData) async {
    final response =
        await authAPIClient.post('/experience-details/', experienceData);
    return response;
  }

  // function to update experience details
  Future<http.Response> updateExperienceDetails(
      Map<String, dynamic> experienceData) async {
    final response =
        await authAPIClient.put('/experience-details/', experienceData);
    return response;
  }

  // function to delete the education details
  Future<http.Response> deleteExperienceDetails(int id) async {
    final response = await authAPIClient.delete('/experience-details/$id/');
    return response;
  }

  // function to get project details
  Future<http.Response> getProjectDetails() async {
    final response = await authAPIClient.get('/project-details/');
    return response;
  }

  // function to add project details
  Future<http.Response> addProjectDetails(
      Map<String, dynamic> projectData) async {
    final response = await authAPIClient.post('/project-details/', projectData);
    return response;
  }

  // function to update project details
  Future<http.Response> updateProjectDetails(
      Map<String, dynamic> projectData) async {
    final response = await authAPIClient.put('/project-details/', projectData);
    return response;
  }

  // function to delete the education details
  Future<http.Response> deleteProjectDetails(int id) async {
    final response = await authAPIClient.delete('/project-details/$id/');
    return response;
  }
}
