import 'dart:convert';
import 'package:gam/chat/models/user_chat_model.dart';

UserChatResponseModel userChatResponseModelFromJson(String str) =>
  UserChatResponseModel.fromJson(json.decode(str));

String userChatResponseModelToJson(UserChatResponseModel data) =>
  json.encode(data.toJson());

class UserChatResponseModel {
  bool result;
  String message;
  UserChatModel userChat;

  UserChatResponseModel({
    required this.result,
    required this.message,
    required this.userChat,
  });

  factory UserChatResponseModel.fromJson(Map<String, dynamic> json) =>
    UserChatResponseModel(
      result: json["result"],
      message: json["message"],
      userChat: UserChatModel.fromJson(json["records"]),
    );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "records": userChat.toJson(),
  };
}
