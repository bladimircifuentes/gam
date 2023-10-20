import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gam/subscription/models/models.dart';


class SubscriptionServices {

  bool _existLogo = false;
  late File _logo;

  bool get existLogo => _existLogo;
  File get logo => _logo;

  Future<bool> checkSubscription() async {

    final prefs = await SharedPreferences.getInstance();

    bool existSubscription = prefs.containsKey('subscription');

    if(existSubscription){
      await _loadEstablishmentLogo();
    }

    return existSubscription;
  }

  Future<SubscriptionModel> getSubscription() async {
    debugPrint('######## EXIST SUBSCRIPTION ########');
    final prefs = await SharedPreferences.getInstance();
    final subscription = json.decode(prefs.getString('subscription')!); 
    return SubscriptionModel.fromJson(subscription);
  }

  Future<bool> saveSubscription(SubscriptionModel subscriptionModel) async {
    try{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('subscription', jsonEncode(subscriptionModel.toJson()));
      debugPrint('######## SAVED SUBSCRIPTION ########');
      return true;
    }catch (e){
      debugPrint('######## ERROR SAVE SUBSCRIPTION ########');
      return false;
    }
  }

  Future<void> _loadEstablishmentLogo() async {
    try {
      const fileName = 'establishment.png';
      final cacheDir = await getTemporaryDirectory();
      final filePath = '${cacheDir.path}/$fileName';
      final file = File(filePath);

      debugPrint('######## LOAD LOGO ESTABLISHMENT LOGO ########');
      _logo = file;
      _existLogo = true;
    } catch (e) {
      debugPrint('ocurrio un error al momento de cargar el logo: $e');
      _existLogo = false;
    }
  }

  Future<void>  saveEstablishmentLogo(String urlLogo) async {
    try {
      const fileName = 'establishment.png';
      final cacheDir = await getTemporaryDirectory();
      final filePath = '${cacheDir.path}/$fileName';
      final file = File(filePath);

      debugPrint('######## DOWNLOADING LOGO ESTABLISHMENT ########');
      final response = await http.get(Uri.parse(urlLogo));
      final Uint8List bytes = response.bodyBytes;
      await file.writeAsBytes(bytes);
      _logo = file;
      debugPrint('######## LOGO ESTABLISHMENT DOWNLOADED ########');

      _existLogo = true;
    } catch (e) {
      debugPrint('ocurrio un error al momento de cargar el logo: $e');
      _existLogo = false;
    }
  }
}