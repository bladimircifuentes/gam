import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:gam/subscription/models/models.dart';
import 'package:gam/subscription/services/subscription_services.dart';


class SubscriptionProvider extends ChangeNotifier{
  bool _existLogo = false;
  int _state = 1;
  late File _logo;
  SubscriptionModel _subscriptionModel = SubscriptionModel(
    application: Application(
      applicationId: 0, 
      description: '', 
      type: ''
    ),
    customerApplicationId: 0,
    logo: '',
    customer: Customer(
      customerId: 0, 
      fullName: '', 
      address: '', 
      contact: '', 
      phones: ''
    ),
    pin: '',
    urlSocket : '',
    url: ''
  );
  
  bool get existLogo => _existLogo;
  int get state => _state;
  SubscriptionModel get subscriptionModel => _subscriptionModel;
  final SubscriptionServices _subscriptionServices = SubscriptionServices();
  
  File get logo => _logo;
  
  Future<bool> checkSubscription() async {
    debugPrint('######## CHECK SUBSCRIPTION ########');

    bool existSubscription = await _subscriptionServices.checkSubscription();
    
    if(existSubscription){
     _subscriptionModel =  await _subscriptionServices.getSubscription();
    }
    if(_subscriptionServices.existLogo){
      _logo = _subscriptionServices.logo;
      _existLogo = true;
    }
    return existSubscription;
  }

  Future<void> subscribe(String codigo, String url) async{
    _state = 2;
    notifyListeners();
    final uri =Uri.parse('$url/$codigo');
    debugPrint('URl: $uri');
    try{

      final res = await http.get(uri,
        headers: {
          'Content-Type':'application/json',
        }
      );

      final jsonResponse = json.decode(res.body);
      final bool result = jsonResponse['result'];
      debugPrint(res.body);
      if(!result){
        debugPrint(jsonResponse['message']);
        _state = 4;
        notifyListeners();
        return;
      }
      await saveData(jsonResponse);
    }catch (e){
      debugPrint('Ocurrio un error: $e');
      _state = 5;
      notifyListeners();
    }
  }
  
  Future<void> saveData(jsonResponse) async{
    final SubscriptionModel subscriptionModel = SubscriptionModel.fromJson(jsonResponse['data']);
    debugPrint('${subscriptionModel.toJson()}');

    if(!await _subscriptionServices.saveSubscription(subscriptionModel)) {
      _state = 5;
      return;
    }

    _state=3;
    _subscriptionModel = subscriptionModel;
    await _subscriptionServices.saveEstablishmentLogo(subscriptionModel.logo);

    if(_subscriptionServices.existLogo){
      _logo = _subscriptionServices.logo;
      _existLogo = true;
    }
    notifyListeners();
  }

  void successSubscription(){
    _state = 1;
    debugPrint('######## SUCCESS SUBSCRIPTION ########');
    notifyListeners();
  }
}