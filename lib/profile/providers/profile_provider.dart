import 'package:flutter/material.dart';

import 'package:gam/common/models/models.dart';
import 'package:gam/profile/services/services.dart';
import 'package:intl/intl.dart';



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
  Map<String, dynamic> getProfileData(){

    String fechaNacimiento = DateFormat('dd-MM-yyyy').format(usuario!.fechaNacimiento);

    Map<String, dynamic> profileData = {
      'Nombres': usuario!.firstName,
      'Apellidos': usuario!.lastName,
      'Correo electronico': usuario!.email,
      'Fecha de nacimiento': fechaNacimiento,
      'Teléfono': usuario!.telefonos,
      'Dirección': usuario!.direccion,
    };

    if(rol! == 3 || rol == 5){
      profileData['Carnet'] = usuario!.carnet;
      profileData['CUI'] = usuario!.cui;
    }

    if(rol! == 5){
      profileData['Grado'] = usuario!.inscriptions[0].cicloGrado.gradocompleto;
    }

    return profileData;
  }

}