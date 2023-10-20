import 'package:gam/common/models/models.dart';

class DepartamentoModel {
    int id;
    int paisId;
    String nombre;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    PaisModel pais;

    DepartamentoModel({
        required this.id,
        required this.paisId,
        required this.nombre,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.pais,
    });

    factory DepartamentoModel.fromJson(Map<String, dynamic> json) => DepartamentoModel(
        id: json["id"],
        paisId: json["pais_id"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        pais: PaisModel.fromJson(json["pais"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pais_id": paisId,
        "nombre": nombre,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "pais": pais.toJson(),
    };
}