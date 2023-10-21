import 'dart:convert';

List<ContactChatModel> contactChatModelFromJson(String str) => 
  List<ContactChatModel>.from(
    json.decode(str).map((x) => ContactChatModel.fromJson(x))
  );

String contactChatModelToJson(List<ContactChatModel> data) =>
  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactChatModel {
  int id;
  String firstName;
  String lastName;
  int role;
  int online;
  String grade;
  String section;

  ContactChatModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.online,
    required this.grade,
    required this.section,
  });

  factory ContactChatModel.fromJson(Map<String, dynamic> json) => 
    ContactChatModel(
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
