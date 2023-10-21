import 'dart:convert';
import 'package:gam/chat/models/message_chat_model.dart';

MessageChatResponseModel messageChatResponseModelFromJson(String str) =>
  MessageChatResponseModel.fromJson(json.decode(str));

String messageChatResponseModelToJson(MessageChatResponseModel data) =>
  json.encode(data.toJson());

class MessageChatResponseModel {
  bool result;
  String message;
  MessageChatModel records;

  MessageChatResponseModel({
    required this.result,
    required this.message,
    required this.records,
  });

  factory MessageChatResponseModel.fromJson(Map<String, dynamic> json) =>
    MessageChatResponseModel(
      result: json["result"],
      message: json["message"],
      records: MessageChatModel.fromJson(json["records"]),
    );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "records": records.toJson(),
  };
}
