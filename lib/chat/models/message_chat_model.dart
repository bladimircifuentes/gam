import 'dart:convert';

MessageChatModel messageChatModelFromJson(String str) => MessageChatModel.fromJson(json.decode(str));

String messageChatModelToJson(MessageChatModel data) => json.encode(data.toJson());

class MessageChatModel {
    int from;
    int to;
    String content;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;

    MessageChatModel({
        required this.from,
        required this.to,
        required this.content,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory MessageChatModel.fromJson(Map<String, dynamic> json) => MessageChatModel(
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
