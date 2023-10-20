// To parse this JSON data, do
//
//     final contactChat = contactChatFromJson(jsonString);

import 'dart:convert';

List<ContactChat> contactChatFromJson(String str) => List<ContactChat>.from(
    json.decode(str).map((x) => ContactChat.fromJson(x)));

String contactChatToJson(List<ContactChat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactChat {
  int id;
  String firstName;
  String lastName;
  int role;
  int online;
  String grade;
  String section;

  ContactChat({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.online,
    required this.grade,
    required this.section,
  });

  factory ContactChat.fromJson(Map<String, dynamic> json) => ContactChat(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        role: json["role"],
        grade: json["grade"],
        section: json["section"],
        online: json["online"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "grade": grade,
        "section": section,
        "online": online,
      };
}
