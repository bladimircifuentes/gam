import 'package:gam/common/models/models.dart';

class Inscription {
    int id;
    int estudianteId;
    int userId;
    int cicloGradoId;
    int esBecado;
    int estado;
    dynamic carnet;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String idHash;
    CicloGrado cicloGrado;

    Inscription({
        required this.id,
        required this.estudianteId,
        required this.userId,
        required this.cicloGradoId,
        required this.esBecado,
        required this.estado,
        required this.carnet,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.idHash,
        required this.cicloGrado,
    });

    factory Inscription.fromJson(Map<String, dynamic> json) => Inscription(
        id: json["id"],
        estudianteId: json["estudiante_id"],
        userId: json["user_id"],
        cicloGradoId: json["ciclo_grado_id"],
        esBecado: json["es_becado"],
        estado: json["estado"],
        carnet: json["carnet"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        idHash: json["id_hash"],
        cicloGrado: CicloGrado.fromJson(json["ciclo_grado"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estudiante_id": estudianteId,
        "user_id": userId,
        "ciclo_grado_id": cicloGradoId,
        "es_becado": esBecado,
        "estado": estado,
        "carnet": carnet,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "id_hash": idHash,
        "ciclo_grado": cicloGrado.toJson(),
    };
}
