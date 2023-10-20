import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:gam/common/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {

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

}