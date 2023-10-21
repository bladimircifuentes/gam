import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/models.dart';
import 'package:gam/common/helpers/token.dart';

class AuthChatService with ChangeNotifier {
  UserChatModel? userChat;
  List<ContactChatModel>? contacts;

  Future<bool> loggedInUserChat(int id, String apiUrl) async {
    debugPrint('AUTH CHAT SERVICE - LOGGED IN USER CHAT');

    final Uri url = Uri.parse('$apiUrl/mobile/user-chat/$id');
    final Map<String, dynamic> dataToken = await json.decode(
      await Token.getToken()
    );

    debugPrint('URL: $url');
    debugPrint('TOKEN: ${dataToken['token']}');

    try {
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
      });

      if(response.statusCode == 200) {
        debugPrint('SUCCESS: ${response.body}');
        final userChatResponse = userChatResponseModelFromJson(response.body);
        userChat = userChatResponse.userChat;
        return true;
      } else {
        debugPrint('FAILED: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('ERROR');
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> userChatContacts(bool refresh, String apiUrl) async {
    debugPrint('AUTH CHAT SERVICE - USER CHAT CONTACTS');

    final prefs = await SharedPreferences.getInstance();
    final key = 'contacts_${userChat!.id}';

    if (prefs.containsKey(key) && !refresh) {
      String contactsJson = prefs.getString(key)!;
      if (contactsJson.isNotEmpty) {
        debugPrint('OBTAINED DATA FROM SHARED PREFERENCES');

        final contactChatResponse = contactChatResponseModelFromJson(contactsJson);
        contacts = contactChatResponse.contacts;
        return true;
      } else {
        debugPrint('OBTAINED DATA FROM SERVER');

        return await _getContacts(prefs, key, apiUrl);
      }
    } else {
      debugPrint('OBTAINED DATA FROM SERVER');

      return await _getContacts(prefs, key, apiUrl);
    }
  }

  Future<bool> _getContacts(SharedPreferences prefs, String key, String apiUrl) async {
    debugPrint('AUTH CHAT SERVICE - GET CONTACTS');

    final Uri url = Uri.parse('$apiUrl/mobile/user-contacts');
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> dataToken = await json.decode(
      await Token.getToken()
    );

    debugPrint('URL: $url');
    debugPrint('TOKEN: ${dataToken['token']}');

    final Map body = {
      "id": userChat!.id,
      "cicloId": userChat!.cicloId,
      "gradoId": userChat!.gradoId,
      "seccionId": userChat!.seccionId,
      "cursoId": userChat!.cursoId
    };

    debugPrint('BODY ${body.toString()}');

    try {
      final response = await http.post(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${dataToken['token']}'
        },
        body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        debugPrint('RESPONSE SUCESS: ${response.body}');

        await prefs.setString(key, response.body);
        final contactChatResponse =
            contactChatResponseModelFromJson(prefs.getString(key)!);
        contacts = contactChatResponse.contacts;
        return true;
      } else {
        debugPrint('RESPONSE FAILED: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('ERROR');
      debugPrint(e.toString());
      return false;
    }
  }
}
