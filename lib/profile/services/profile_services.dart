import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/common/models/models.dart';

import 'package:shared_preferences/shared_preferences.dart';


class ProfileServices {
  Future<bool> existUser() async{
    debugPrint('######## CHECK SUBSCRIPTION ########');
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('responseModel');

  }

  Future<LoggedModel> getLogged() async {
    debugPrint('######## GET LOGGED ########');
    final prefs = await SharedPreferences.getInstance();
    final responseModelJson = json.decode(prefs.getString('responseModel')!); 

    ResponseModel responseModel = ResponseModel.fromJson(responseModelJson);

    return responseModel.payload.logged;
  }

}