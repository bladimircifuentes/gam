import 'dart:convert';
import 'package:gam/chat/models/message_chat_model.dart';

MessageListChatResponseModel messageListChatResponseModelFromJson(String str) =>
  MessageListChatResponseModel.fromJson(json.decode(str));

String messageListChatResponseModelToJson(MessageListChatResponseModel data) =>
  json.encode(data.toJson());

class MessageListChatResponseModel {
  bool result;
  String message;
  List<MessageChatModel> records;

  MessageListChatResponseModel({
    required this.result,
    required this.message,
    required this.records,
  });

  factory MessageListChatResponseModel.fromJson(Map<String, dynamic> json) =>
    MessageListChatResponseModel(
      result: json["result"],
      message: json["message"],
      records: List<MessageChatModel>.from(
          json["records"].map((x) => MessageChatModel.fromJson(x))),
    );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}
