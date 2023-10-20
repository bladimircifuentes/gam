import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/common/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileServices {
  final _storage = const FlutterSecureStorage();
  Future<bool> existUser() async{
    debugPrint('######## CHECK SUBSCRIPTION ########');
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('responseModel');

  }

  Future<Logged> getLogged() async {
    debugPrint('######## GET LOGGED ########');
    final prefs = await SharedPreferences.getInstance();
    final responseModelJson = json.decode(prefs.getString('responseModel')!); 

    ResponseModel responseModel = ResponseModel.fromJson(responseModelJson);

    return responseModel.payload.logged;
  }

  Future<String?> getToken() async{
    debugPrint('######## GET TOKEN ########');
    final token = await _storage.read(key: 'token');
    return token;
  }
}