import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mero_career/models/job/job_category_model.dart';
import 'package:mero_career/utils/api_config.dart';

import '../utils/auth_api_client.dart';

class ChatServices {
  // to post the job
  final AuthAPIClient _authAPIClient = AuthAPIClient();

  // to get or create a chat room
  Future<http.Response> getOrCreateChatRoom(int jobSeekerId) async {
    try {
      final response =
          await _authAPIClient.post('/chat-room/$jobSeekerId/', {});
      return response;
    } catch (e) {
      throw Exception('Failed to create chat room $e');
    }
  }

  // to get list of chat room
  Future<http.Response> getChatRooms() async {
    try {
      final response = await _authAPIClient.get('/chat-room/');
      return response;
    } catch (e) {
      throw Exception('Failed to get chat rooms $e');
    }
  }

  // to get messages of chat rooms
  Future<http.Response> getMessages(int chatID) async {
    try {
      final response = await _authAPIClient.get('/chat-room/$chatID/messages/');
      return response;
    } catch (e) {
      throw Exception('Failed to get messages of chat rooms $e');
    }
  }

  // to send messages of chat rooms
  Future<http.Response> sendMessage(
      int chatID, Map<String, dynamic> chatContent) async {
    try {
      final response = await _authAPIClient.post(
          '/chat-room/$chatID/messages/', chatContent);
      return response;
    } catch (e) {
      throw Exception('Failed to send messages to chat rooms $e');
    }
  }

  // to get messages of chat rooms with job if
  Future<http.Response> getMessagesWithJobseeker(int jobSeekerId) async {
    try {
      final response = await _authAPIClient
          .get('/jobseeker-chat-room/$jobSeekerId/messages/');
      return response;
    } catch (e) {
      throw Exception('Failed to get messages with that job id $e');
    }
  }
}
