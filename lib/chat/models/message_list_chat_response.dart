// To parse this JSON data, do
//
//     final messageListChatResponse = messageListChatResponseFromJson(jsonString);

import 'dart:convert';
import 'package:gam/chat/models/message_chat.dart';

MessageListChatResponse messageListChatResponseFromJson(String str) =>
    MessageListChatResponse.fromJson(json.decode(str));

String messageListChatResponseToJson(MessageListChatResponse data) =>
    json.encode(data.toJson());

class MessageListChatResponse {
  bool result;
  String message;
  List<MessageChat> records;

  MessageListChatResponse({
    required this.result,
    required this.message,
    required this.records,
  });

  factory MessageListChatResponse.fromJson(Map<String, dynamic> json) =>
      MessageListChatResponse(
        result: json["result"],
        message: json["message"],
        records: List<MessageChat>.from(
            json["records"].map((x) => MessageChat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
      };
}
