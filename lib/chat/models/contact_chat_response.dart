// To parse this JSON data, do
//
//     final contactChatResponse = contactChatResponseFromJson(jsonString);

import 'dart:convert';
import 'package:gam/chat/models/contact_chat.dart';

ContactChatResponse contactChatResponseFromJson(String str) =>
    ContactChatResponse.fromJson(json.decode(str));

String contactChatResponseToJson(ContactChatResponse data) =>
    json.encode(data.toJson());

class ContactChatResponse {
  bool result;
  String message;
  List<ContactChat> contacts;

  ContactChatResponse({
    required this.result,
    required this.message,
    required this.contacts,
  });

  factory ContactChatResponse.fromJson(Map<String, dynamic> json) =>
      ContactChatResponse(
        result: json["result"],
        message: json["message"],
        contacts: List<ContactChat>.from(
          json["records"].map((x) => ContactChat.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "records": List<dynamic>.from(contacts.map((x) => x.toJson())),
      };
}
