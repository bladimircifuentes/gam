import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gam/common/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _storage = const FlutterSecureStorage();
  Future<bool> saveResponse(ResponseModel responseModel) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('responseModel', jsonEncode(responseModel.toJson()));
      debugPrint('######## SAVED RESPONSE ########');
      return true;
    }catch (e){
      debugPrint('######## ERROR SAVE RESPONSE ########');
      return false;
    }
  }

  Future<bool> saveToken(String token) async{
    try {
      await _storage.write(key: 'token', value: token);
      debugPrint('######## SAVED TOKEN ########');
      return true;
    } catch (e) {
      debugPrint('######## ERROR SAVE TOKEN ########');
      return false;
    }
    
  }
}