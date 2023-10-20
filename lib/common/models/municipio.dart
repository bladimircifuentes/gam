import 'package:gam/common/models/models.dart';

class Municipio {
    int id;
    int departamentoId;
    String descripcion;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    Departamento departamento;

    Municipio({
        required this.id,
        required this.departamentoId,
        required this.descripcion,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.departamento,
    });

    factory Municipio.fromJson(Map<String, dynamic> json) => Municipio(
        id: json["id"],
        departamentoId: json["departamento_id"],
        descripcion: json["descripcion"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        departamento: Departamento.fromJson(json["departamento"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "departamento_id": departamentoId,
        "descripcion": descripcion,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "departamento": departamento.toJson(),
    };
}