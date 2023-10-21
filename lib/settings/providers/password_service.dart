import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/settings/models/models.dart';

import 'package:http/http.dart' as http;

class PasswordProvider extends ChangeNotifier{
  int _state = 1;
  /*
    state => 1 inital state
    state => 2 process 
    state => 3 success 
    state => 4 error 
    state => 5 error server
  */

  int get state => _state;

  Future<void> restorePassword(String url, String email) async{
    _state = 2;
    notifyListeners();
    final uri = Uri.parse('$url/api/config/solicitarpassword');
    debugPrint('URl: $uri');

    try{
      final data = {
        'email_recuperacion' : email,
      };

      final res = await http.post(uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type':'application/json',
        }
      );

      final jsonResponse = json.decode(res.body);
      final bool result = jsonResponse['result'];

      if(result){
        final response = responseModelFromJson(res.body);
        debugPrint(response.message);
        _state=3;
        notifyListeners();
      }else{
        _state = 4;
        notifyListeners();
      }

    }catch (e){
      debugPrint('Ocurrio un error: $e');
      _state = 5;
      notifyListeners();
    }
  }

  Future<void> changePassword({
    required String url,
    required String email,
    required String oldPassword,
    required String newPassword
  }) async{
    _state = 2;
    notifyListeners();
    final uri = Uri.parse('$url/mobile/change-password');
    debugPrint('URl: $uri');

    try{
      final data = {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword
      };

      final res = await http.post(uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type':'application/json',
        }
      );

       if(res.statusCode == 200){
        final response = responseModelFromJson(res.body);
        debugPrint(response.message);
        _state=3;
        notifyListeners();
      }else{
        _state = 4;
        notifyListeners();
      }

    }catch (e){
      debugPrint('Ocurrio un error: $e');
      _state = 5;
      notifyListeners();
    }
  }
}