import 'package:flutter/material.dart';
import 'package:gam/common/global/environment.dart';

class EnvironmentProvider extends ChangeNotifier {
  String _subscriptionUrl = '';
  String _apiUrl = '';
  String _socketUrl = '';
  
  String get subscriptionUrl => _subscriptionUrl;
  String get apiUrl => _apiUrl;
  String get socketUrl => _socketUrl;

  EnvironmentProvider(){
    _loadEnvironment();
  }

  void _loadEnvironment (){
    _subscriptionUrl = Environment.subscriptionUrl;
    _apiUrl = Environment.apiUrl;
    _socketUrl = Environment.socketUrl;
    notifyListeners();
  }

  void changeEnvironment ({required String url, required String urlSocket}){
    _apiUrl = url;
    _socketUrl = urlSocket;
    notifyListeners();
  }
}