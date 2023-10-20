import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gam/common/global/environment.dart';
import 'package:http/http.dart' as http;
import 'package:gam/chat/models/contact_chat.dart';
import 'package:gam/chat/models/contact_chat_response.dart';
import 'package:gam/chat/models/user_chat.dart';
import 'package:gam/chat/models/user_chat_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthChatService with ChangeNotifier {
  UserChat? userChat;
  List<ContactChat>? contacts;

  Future<bool> loggedInUserChat(int id) async {
    final Uri url = Uri.parse('${Environment.apiUrl}/user-chat/$id');
    const storage = FlutterSecureStorage();
    final String token = await storage.read(key: 'token') ?? '';

    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    });

    if (response.statusCode == 200) {
      debugPrint('success: ${response.body}');
      final userChatResponse = userChatResponseFromJson(response.body);
      userChat = userChatResponse.userChat;
      return true;
    } else {
      debugPrint('failed: ${response.body}');
      return false;
    }
  }

  Future<bool> userChatContacts(bool refresh) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'contacts_${userChat!.id}';

    if (prefs.containsKey(key) && !refresh) {
      String contactsJson = prefs.getString(key)!;
      if (contactsJson.isNotEmpty) {
        final contactChatResponse = contactChatResponseFromJson(contactsJson);
        contacts = contactChatResponse.contacts;
        return true;
      } else {
        return await _getContacts(prefs, key);
      }
    } else {
      return await _getContacts(prefs, key);
    }
  }

  Future<bool> _getContacts(SharedPreferences prefs, String key) async {
    final Uri url = Uri.parse('${Environment.apiUrl}/user-contacts');
    final prefs = await SharedPreferences.getInstance();
    const storage = FlutterSecureStorage();
    final String token = await storage.read(key: 'token') ?? '';

    debugPrint('token: $token');

    final Map body = {
      "id": userChat!.id,
      "cicloId": userChat!.cicloId,
      "gradoId": userChat!.gradoId,
      "seccionId": userChat!.seccionId,
      "cursoId": userChat!.cursoId
    };

    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      await prefs.setString(key, response.body);
      final contactChatResponse =
          contactChatResponseFromJson(prefs.getString(key)!);
      contacts = contactChatResponse.contacts;
      return true;
    } else {
      return false;
    }
  }
}
