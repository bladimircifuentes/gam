import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/message_chat_model.dart';
import 'package:gam/chat/models/message_chat_response_model.dart';

class MessageChatService with ChangeNotifier {
  Future<MessageChatModel?> saveMessage(String messageChat, String apiUrl) async {
    debugPrint('MESSAGE CHAT SERVICE - SAVE MESSAGE');

    try {
      final Uri url = Uri.parse('$apiUrl/mobile/new-message');
      final Map<String, dynamic> dataToken = await json.decode(
        await Token.getToken()
      );

      debugPrint('URL: $url');
      debugPrint('TOKEN: ${dataToken['token']}');
      debugPrint('BODY: $messageChat');

      final response = await http.post(
        url,
        body: messageChat,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
        }
      );

      if(response.statusCode == 200) {
        debugPrint('RESPONSE SUCESS: ${response.body}');
        final messageChatResponse = messageChatResponseModelFromJson(response.body);
        return messageChatResponse.records;
      } else {
        debugPrint('RESPONSE FAILED: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('ERROR');
      debugPrint(e.toString());
      return null;
    }
  }
}
