// To parse this JSON data, do
//
//     final userChatResponse = userChatResponseFromJson(jsonString);

import 'dart:convert';
import 'package:gam/chat/models/user_chat.dart';

UserChatResponse userChatResponseFromJson(String str) =>
    UserChatResponse.fromJson(json.decode(str));

String userChatResponseToJson(UserChatResponse data) =>
    json.encode(data.toJson());

class UserChatResponse {
  bool result;
  String message;
  UserChat userChat;

  UserChatResponse({
    required this.result,
    required this.message,
    required this.userChat,
  });

  factory UserChatResponse.fromJson(Map<String, dynamic> json) =>
      UserChatResponse(
        result: json["result"],
        message: json["message"],
        userChat: UserChat.fromJson(json["records"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "records": userChat.toJson(),
      };
}
