// To parse this JSON data, do
//
//     final Customer = customerDtoFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
    int customerId;
    String fullName;
    String address;
    String contact;
    String phones;

    Customer({
        required this.customerId,
        required this.fullName,
        required this.address,
        required this.contact,
        required this.phones,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        customerId: json["customerId"],
        fullName: json["fullName"],
        address: json["address"],
        contact: json["contact"],
        phones: json["phones"],
    );

    Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "fullName": fullName,
        "address": address,
        "contact": contact,
        "phones": phones,
    };
}
