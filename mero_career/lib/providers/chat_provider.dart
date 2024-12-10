import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mero_career/services/chat_services.dart';

import '../services/auth_services.dart';
import '../services/chat_services.dart';
import '../views/shared/login/login_page.dart';
import '../views/widgets/custom_flushbar_message.dart';

class ChatProvider extends ChangeNotifier {
  List<dynamic> _chatDetails = [];

  bool _isLoading = false;

  List<dynamic>? get chatDetails => _chatDetails;

  bool get isLoading => _isLoading;
  ChatServices chatServices = ChatServices();

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

  // to get message of a selected job seeker
  Future<http.Response?> fetchAllMessagesWithJobseeker(int jobSeekerID) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatServices.getMessagesWithJobseeker(jobSeekerID);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _chatDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error getting chat details with job id: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to get message of a selected chat room
  Future<http.Response?> fetchAllMessages(int roomId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatServices.getMessages(roomId);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _chatDetails = responseData;
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while fetching job seeker profile: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to create chat room and fetch chat details if already exists
  Future<http.Response?> getOrCreateChatRoom(int jobSeekerId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatServices.getOrCreateChatRoom(jobSeekerId);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _chatDetails = responseData;
        notifyListeners();
      } else if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        int recentlyCreatedRoomId = responseData['id'];
        fetchAllMessages(recentlyCreatedRoomId);
        notifyListeners();
      }
      return response;
    } catch (e) {
      print("Error while fetching job seeker profile: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // to send message in the chat room
  Future<http.Response?> sendMessage(
      int roomId, Map<String, dynamic> contentData) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await chatServices.sendMessage(roomId, contentData);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _chatDetails = responseData;
        notifyListeners();
      }

      return response;
    } catch (e) {
      print("Error while fetching messages of selected chat room: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
