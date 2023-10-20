// To parse this JSON data, do
//
//     final messageChatResponse = messageChatResponseFromJson(jsonString);

import 'dart:convert';
import 'package:gam/chat/models/message_chat.dart';

MessageChatResponse messageChatResponseFromJson(String str) => MessageChatResponse.fromJson(json.decode(str));

String messageChatResponseToJson(MessageChatResponse data) => json.encode(data.toJson());

class MessageChatResponse {
    bool result;
    String message;
    MessageChat records;

    MessageChatResponse({
        required this.result,
        required this.message,
        required this.records,
    });

    factory MessageChatResponse.fromJson(Map<String, dynamic> json) => MessageChatResponse(
        result: json["result"],
        message: json["message"],
        records: MessageChat.fromJson(json["records"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "records": records.toJson(),
    };
}
