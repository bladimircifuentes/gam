// To parse this JSON data, do
//
//     final messageChat = messageChatFromJson(jsonString);

import 'dart:convert';

MessageChat messageChatFromJson(String str) => MessageChat.fromJson(json.decode(str));

String messageChatToJson(MessageChat data) => json.encode(data.toJson());

class MessageChat {
    int from;
    int to;
    String content;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    MessageChat({
        required this.from,
        required this.to,
        required this.content,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory MessageChat.fromJson(Map<String, dynamic> json) => MessageChat(
        from: json["from"],
        to: json["to"],
        content: json["content"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "content": content,
        "updated_at": (updatedAt != null) ? updatedAt!.toIso8601String() : null,
        "created_at": (createdAt != null) ? createdAt!.toIso8601String() : null,
        "id": id,
    };
}
