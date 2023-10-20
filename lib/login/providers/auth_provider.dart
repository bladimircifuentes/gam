import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/common/helpers/token.dart';
import 'package:gam/common/models/models.dart';
import 'package:gam/login/services/services.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  int _state = 1;
  int get state => _state;
  
  Future<void> login({
    required String email, 
    required String password,
    required String apiUrl
  }) async{
    final uri =Uri.parse('$apiUrl/mobile/login');
    _state = 2;
    notifyListeners();

    debugPrint('correo $email');
    debugPrint('password $password');
    
    debugPrint('URL $uri');
    final data = {
      'email': email,
      'password' : password,
    };
    try {
      final resp = await http.post(uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type':'application/json'
        }
      );

      if(resp.statusCode != 200){
        debugPrint('######## LOGIN DATOS INCORRECTOS ########');
        _state = 4;
        notifyListeners();
        return;
      }

      debugPrint('######## LOGIN EXITOSO ########');
      final ResponseModel response = responseModelFromJson(resp.body);
      debugPrint(resp.body);
      await _saveData(response);
    } catch (e) {
      debugPrint(e.toString());
      _state = 5;
      notifyListeners();
    }
  }

  Future<void> _saveData(ResponseModel responseModel) async{
    AuthServices authServices = AuthServices();
    if(!await authServices.saveResponse(responseModel)){
      _state = 5;
      notifyListeners();
      return;
    }

    String token = responseModel.payload.accessToken;
    int expiryTime = responseModel.payload.expiresIn;  

    if(!await Token.saveToke(token, expiryTime)){
      _state = 5;
      notifyListeners();
      return;
    }

    _state = 3;
    notifyListeners();
  }

  Future<void> loginSucces() async{
    _state = 1;
    notifyListeners();
  }
}