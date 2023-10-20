import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gam/common/global/environment.dart';
import 'package:gam/common/models/models.dart';
import 'package:gam/profile/services/services.dart';

import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier{
  bool _existUsuario = false;
  Logged? _usuario;
  int? _rol;
  int _state = 1;
  int get state => _state;
  bool get existUsuario => _existUsuario;
  Logged? get usuario => _usuario;
  int? get rol => _rol;

  

  final ProfileServices _profileServices = ProfileServices();

  Future<void> login(String email, String password) async{
    final uri =Uri.parse('${Environment.apiUrl}/login');
    _state = 2;
    notifyListeners();
    
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

  Future<void> checkProfile() async {
    if(await _profileServices.existUser()){
      _existUsuario = true;
      _usuario = await _profileServices.getLogged();
      _rol = _usuario!.role;
    }
  }

  Future<void> _saveData(ResponseModel responseModel) async{
    AuthServices authServices = AuthServices();
    if(!await authServices.saveResponse(responseModel)){
      _state = 5;
      notifyListeners();
      return;
    }

    if(!await authServices.saveToken(responseModel.payload.accessToken)){
      _state = 5;
      notifyListeners();
      return;
    }
    _existUsuario = true;
    _rol = responseModel.payload.logged.role;
    _usuario = responseModel.payload.logged;

    _state = 3;
    notifyListeners();
  }

  Future<void> loginSucces() async{
    _state = 1;
    notifyListeners();
  }
}