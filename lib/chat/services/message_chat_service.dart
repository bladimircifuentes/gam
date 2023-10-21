import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gam/common/global/environment.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/message_chat.dart';
import 'package:gam/chat/models/message_chat_response.dart';

class MessageChatService with ChangeNotifier {
  Future<MessageChat?> saveMessage(String messageChat) async {
    final Uri url = Uri.parse('${Environment.apiUrl}/new-message');
    final Map<String, dynamic> dataToken = await json.decode(
      await Token.getToken()
    );

    final response = await http.post(url, body: messageChat, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
    });

    if (response.statusCode == 200) {
      final messageChatResponse = messageChatResponseFromJson(response.body);
      return messageChatResponse.records;
    } else {
      return null;
    }
  }
}
