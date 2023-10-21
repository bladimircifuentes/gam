import 'dart:convert';

UserChatModel userChatFromJson(String str) =>
  UserChatModel.fromJson(json.decode(str));

String userChatToJson(UserChatModel data) => json.encode(data.toJson());

class UserChatModel {
  int id;
  String firstName;
  String lastName;
  int role;
  List<int> cicloId;
  List<int> gradoId;
  List<int> seccionId;
  List<int> cursoId;

  UserChatModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.cicloId,
    required this.gradoId,
    required this.seccionId,
    required this.cursoId,
  });

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    cicloId: List<int>.from(json["ciclo_id"].map((x) => x)),
    gradoId: List<int>.from(json["grado_id"].map((x) => x)),
    seccionId: List<int>.from(json["seccion_id"].map((x) => x)),
    cursoId: List<int>.from(json["curso_id"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "ciclo_id": List<dynamic>.from(cicloId.map((x) => x)),
    "grado_id": List<dynamic>.from(gradoId.map((x) => x)),
    "seccion_id": List<dynamic>.from(seccionId.map((x) => x)),
    "curso_id": List<dynamic>.from(cursoId.map((x) => x)),
  };
}
