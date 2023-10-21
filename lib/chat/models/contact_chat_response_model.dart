import 'dart:convert';
import 'package:gam/chat/models/contact_chat_model.dart';

ContactChatResponseModel contactChatResponseModelFromJson(String str) =>
  ContactChatResponseModel.fromJson(json.decode(str));

String contactChatResponseModelToJson(ContactChatResponseModel data) =>
  json.encode(data.toJson());

class ContactChatResponseModel {
  bool result;
  String message;
  List<ContactChatModel> contacts;

  ContactChatResponseModel({
    required this.result,
    required this.message,
    required this.contacts,
  });

  factory ContactChatResponseModel.fromJson(Map<String, dynamic> json) =>
    ContactChatResponseModel(
      result: json["result"],
      message: json["message"],
      contacts: List<ContactChatModel>.from(
        json["records"].map((x) => ContactChatModel.fromJson(x)),
      ),
    );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "records": List<dynamic>.from(contacts.map((x) => x.toJson())),
  };
}
