// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

import 'package:gam/subscription/models/models.dart';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
    int customerApplicationId;
    Customer customer;
    Application application;
    String pin;
    String url;
    String logo;

    SubscriptionModel({
        required this.customerApplicationId,
        required this.customer,
        required this.application,
        required this.pin,
        required this.url,
        required this.logo,
    });

    factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
        customerApplicationId: json["customerApplicationId"],
        customer: Customer.fromJson(json["customer"]),
        application: Application.fromJson(json["application"]),
        pin: json["pin"],
        url: json["url"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "customerApplicationId": customerApplicationId,
        "customer": customer.toJson(),
        "application": application.toJson(),
        "pin": pin,
        "url": url,
        "logo": logo,
    };
}
