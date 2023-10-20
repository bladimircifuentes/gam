import 'package:flutter/material.dart';

import 'package:gam/common/models/models.dart';
import 'package:gam/profile/services/services.dart';



class ProfileProvider extends ChangeNotifier{
  bool _existUsuario = false;
  LoggedModel? _usuario;
  int? _rol;

  bool get existUsuario => _existUsuario;
  LoggedModel? get usuario => _usuario;
  int? get rol => _rol;

  final ProfileServices _profileServices = ProfileServices();

  Future<void> checkProfile() async {
    if(await _profileServices.existUser()){
      _existUsuario = true;
      _usuario = await _profileServices.getLogged();
      _rol = _usuario!.role;
    }
  }

}