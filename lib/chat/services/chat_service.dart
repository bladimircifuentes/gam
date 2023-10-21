import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/message_chat_model.dart';
import 'package:gam/chat/models/contact_chat_model.dart';
import 'package:gam/chat/models/message_list_chat_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService with ChangeNotifier {
  ContactChatModel? contactFor;

  int _cursor = 0;
  int get cursor => _cursor;
  set cursor(int value) {
    _cursor = value;
    notifyListeners();
  }

  Future<List<MessageChatModel>> getChat(int userFromID, int userToID, String apiUrl) async {
    debugPrint('CHAT SERVICE - GET CHAT');

    try {

      Uri url = Uri.parse('$apiUrl/mobile/messages');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> dataToken = await json.decode(
        await Token.getToken()
      );
      String key = 'chat_${userFromID}_$userToID';
      Map<String, dynamic> body = {
        'from': userFromID,
        'to': userToID,
        'cursor': cursor
      };

      debugPrint('URL: $url');
      debugPrint('TOKEN: ${dataToken['token']}');
      debugPrint('BODY: ${body.toString()}');

      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE SUCCESS: ${response.body}');

        prefs.setString(key, response.body);
        final messagesChatResponse =
            messageListChatResponseModelFromJson(response.body);
        cursor = messagesChatResponse
            .records[messagesChatResponse.records.length - 1].id!;
        return messagesChatResponse.records;
      } else {
        debugPrint('RESPONSE FAILED: ${response.body}');

        if (prefs.containsKey(key)) {
          final messagesChatResponseStore = prefs.getString(key)!;
          final messagesChatResponse =
              messageListChatResponseModelFromJson(messagesChatResponseStore);
          return messagesChatResponse.records;
        } else {
          return [];
        }
      }
    } catch (e) {
      debugPrint('ERROR');
      debugPrint(e.toString());
      return [];
    }
  }
}
