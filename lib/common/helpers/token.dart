import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {

  static Future<bool> validToke() async{
    const storage =  FlutterSecureStorage();

    String? dataTokeString = await storage.read(key: 'token');

    if (dataTokeString != null) {
      debugPrint('######## TOKEN EXISTENTE ########');
      Map<String, dynamic> dataToke = json.decode(dataTokeString);
      debugPrint('DATA TOKE: $dataToke');

      int expiryTime = dataToke['expiryTime'];
      DateTime registrationDate = DateTime.parse(dataToke['registrationDate']);
      DateTime now = DateTime.now();
      Duration difference = now.difference(registrationDate);

      int secondsDifference = difference.inSeconds;

      return secondsDifference > expiryTime ? false : true;

    }
    debugPrint('######## NO EXISTE TOKEN ########');
    return false;
  }

  static Future<String> getToken() async{
    debugPrint('######## GET TOKEN ########');

    const storage =  FlutterSecureStorage();
    
    final token = await storage.read(key: 'token');
    
    return token!;
  }

  static Future<bool> saveToke(String token, int expiryTime) async{
    const storage =  FlutterSecureStorage();
    
    Map<String, dynamic> dataToke = {
      'token' : token,
      'registrationDate' : DateTime.now().toString(),
      'expiryTime' : expiryTime
    };
    String dataTokeString = json.encode(dataToke);
    
    try {
      await storage.write(key: 'token', value: dataTokeString);
      debugPrint('######## SAVED TOKEN ########');
      return true;
    } catch (e) {
      debugPrint('######## ERROR SAVE TOKEN ########');
      return false;
    }
  }
}