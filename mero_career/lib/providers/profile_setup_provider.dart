import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/profile_setup_services.dart';

import '../services/auth_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class ProfileSetupProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _profileAnalysisData = {};
  List<dynamic>? _skillsDetails = [];
  List<dynamic>? _educationDetails = [];
  List<dynamic>? _experienceDetails = [];
  List<dynamic>? _projectDetails = [];

  List? get skillsDetails => _skillsDetails;

  Map<String, dynamic>? get profileAnalysisData => _profileAnalysisData;

  bool get isLoading => _isLoading;

  List? get educationDetails => _educationDetails;

  List? get experienceDetails => _experienceDetails;

  List? get projectDetails => _projectDetails;

  ProfileSetupServices profileSetupServices = ProfileSetupServices();

  // function to handle logout
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

  // function to get profile analysis
  Future<http.Response?> fetchProfileAnalysis() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await profileSetupServices.getProfileSetupAnalysis();
      if (response.statusCode == 200) {
        final responseData = await json.decode(response.body);
        _profileAnalysisData = await responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error fetching analysis details..... $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch all skills data
  Future<http.Response?> fetchSkillsData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await profileSetupServices.getSkillsDetails();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _skillsDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error fetching skills details..... $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to update skills data
  Future<void> updateSkillsData(
      BuildContext context, Map<String, dynamic> skillsData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await profileSetupServices.updateSkills(skillsData);
      print(response.body);
      if (response.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully updated skills details",
            type: MessageType.success);
        fetchSkillsData();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't update skills details !",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error updating skills");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch education details
  Future<http.Response?> fetchEducationDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await profileSetupServices.getEducationDetails();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _educationDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error fetching education details..... $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to add education details
  Future<http.Response?> addEducationDetails(
      BuildContext context, Map<String, dynamic> educationData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await profileSetupServices.addEducationDetails(educationData);
      if (response.statusCode == 201) {
        showCustomFlushbar(
            context: context,
            message: "Successfully added education details",
            type: MessageType.success);
        fetchEducationDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message:
                "Sorry !, Couldn't add education details. Check all the details properly .",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
      return response;
    } catch (e) {
      print("Error adding education details, $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to update education details
  Future<void> updateEducationDetails(
      BuildContext context, Map<String, dynamic> educationData, int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await profileSetupServices.updateEducationDetails(educationData, id);
      if (response.statusCode == 200) {
        showCustomFlushbar(
            context: context,
            message: "Successfully updated education details",
            type: MessageType.success);
        fetchEducationDetails();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message:
                "Sorry !, Couldn't update education details. Check all the data properly .",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error updating education details $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ----------- function to delete education details -----------
  Future<void> deleteEducationDetails(BuildContext context, int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await profileSetupServices.deleteEducationDetails(id);
      if (response.statusCode == 204) {
        showCustomFlushbar(
            context: context,
            message: "Successfully deleted education details",
            type: MessageType.success);
        fetchEducationDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't delete education details",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error deleting education details $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to fetch experience details
  Future<http.Response?> fetchExperienceDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await profileSetupServices.getExperienceDetails();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _experienceDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error fetching experience details..... $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to add expereince data
  Future<http.Response?> addExperienceDetails(
      BuildContext context, Map<String, dynamic> experienceData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await profileSetupServices.addExperienceDetails(experienceData);
      if (response.statusCode == 201) {
        showCustomFlushbar(
            context: context,
            message: "Successfully added experience details",
            type: MessageType.success);
        fetchExperienceDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message:
                "Sorry !, Couldn't add experience details. Check all the details properly .",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
      return response;
    } catch (e) {
      print("Error adding education details, $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// function to delete experience details
  Future<void> deleteExperienceDetails(BuildContext context, int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await profileSetupServices.deleteExperienceDetails(id);
      if (response.statusCode == 204) {
        showCustomFlushbar(
            context: context,
            message: "Successfully deleted experience details",
            type: MessageType.success);
        fetchExperienceDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't delete experience details",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error deleting experience details $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// function to fetch project details
  Future<http.Response?> fetchProjectDetails() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await profileSetupServices.getProjectDetails();
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _projectDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error fetching project details..... $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to add education details
  Future<http.Response?> addProjectDetails(
      BuildContext context, Map<String, dynamic> projectData) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response =
          await profileSetupServices.addProjectDetails(projectData);
      if (response.statusCode == 201) {
        showCustomFlushbar(
            context: context,
            message: "Successfully added project details",
            type: MessageType.success);
        fetchProjectDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message:
                "Sorry !, Couldn't add project details. Check all the details properly .",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
      return response;
    } catch (e) {
      print("Error adding project details, $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // function to delete project details
  Future<void> deleteProjectDetails(BuildContext context, int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await profileSetupServices.deleteProjectDetails(id);
      if (response.statusCode == 204) {
        showCustomFlushbar(
            context: context,
            message: "Successfully deleted project details",
            type: MessageType.success);
        fetchProjectDetails();
        fetchProfileAnalysis();
        notifyListeners();
      } else if (response.statusCode == 400) {
        showCustomFlushbar(
            context: context,
            message: "Sorry !, Couldn't delete project details",
            type: MessageType.error);
      } else if (response.statusCode == 401) {
        handleLogoutUser(context);
      }
    } catch (e) {
      print("Error deleting project details $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
