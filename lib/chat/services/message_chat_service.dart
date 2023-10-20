import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gam/common/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/message_chat.dart';
import 'package:gam/chat/models/message_chat_response.dart';

class MessageChatService with ChangeNotifier {
  Future<MessageChat?> saveMessage(String messageChat) async {
    final Uri url = Uri.parse('${Environment.apiUrl}/new-message');
    const storage = FlutterSecureStorage();
    final String token = await storage.read(key: 'token') ?? '';

    final response = await http.post(url, body: messageChat, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final messageChatResponse = messageChatResponseFromJson(response.body);
      return messageChatResponse.records;
    } else {
      return null;
    }
  }
}
