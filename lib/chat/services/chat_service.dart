import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gam/common/global/environment.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/message_chat.dart';
import 'package:gam/chat/models/contact_chat.dart';
import 'package:gam/chat/models/message_list_chat_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService with ChangeNotifier {
  ContactChat? contactFor;

  int _cursor = 0;
  int get cursor => _cursor;
  set cursor(int value) {
    _cursor = value;
    notifyListeners();
  }

  Future<List<MessageChat>> getChat(int userFromID, int userToID) async {
    try {
      final Uri url = Uri.parse('${Environment.apiUrl}/messages');
      final prefs = await SharedPreferences.getInstance();
      final Map<String, dynamic> dataToken = await json.decode(
        await Token.getToken()
      );

      final key = 'chat_${userFromID}_$userToID';
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
        },
        body:
            jsonEncode({'from': userFromID, 'to': userToID, 'cursor': cursor}),
      );

      if (response.statusCode == 200) {
        prefs.setString(key, response.body);
        final messagesChatResponse =
            messageListChatResponseFromJson(response.body);
        cursor = messagesChatResponse
            .records[messagesChatResponse.records.length - 1].id!;
        return messagesChatResponse.records;
      } else {
        if (prefs.containsKey(key)) {
          final messagesChatResponseStore = prefs.getString(key)!;
          final messagesChatResponse =
              messageListChatResponseFromJson(messagesChatResponseStore);
          return messagesChatResponse.records;
        } else {
          return [];
        }
      }
    } catch (e) {
      return [];
    }
  }
}
