import 'package:gam/common/models/models.dart';

class CicloGrado {
    int id;
    int cicloId;
    int gradoId;
    int seccionId;
    int limiteEstudiantes;
    int cantEstudiantes;
    int estado;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String gradocompleto;
    String idHash;
    Grado grado;
    Pais seccion;
    Ciclo ciclo;

    CicloGrado({
        required this.id,
        required this.cicloId,
        required this.gradoId,
        required this.seccionId,
        required this.limiteEstudiantes,
        required this.cantEstudiantes,
        required this.estado,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.gradocompleto,
        required this.idHash,
        required this.grado,
        required this.seccion,
        required this.ciclo,
    });

    factory CicloGrado.fromJson(Map<String, dynamic> json) => CicloGrado(
        id: json["id"],
        cicloId: json["ciclo_id"],
        gradoId: json["grado_id"],
        seccionId: json["seccion_id"],
        limiteEstudiantes: json["limite_estudiantes"],
        cantEstudiantes: json["cant_estudiantes"],
        estado: json["estado"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        gradocompleto: json["gradocompleto"],
        idHash: json["id_hash"],
        grado: Grado.fromJson(json["grado"]),
        seccion: Pais.fromJson(json["seccion"]),
        ciclo: Ciclo.fromJson(json["ciclo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ciclo_id": cicloId,
        "grado_id": gradoId,
        "seccion_id": seccionId,
        "limite_estudiantes": limiteEstudiantes,
        "cant_estudiantes": cantEstudiantes,
        "estado": estado,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "gradocompleto": gradocompleto,
        "id_hash": idHash,
        "grado": grado.toJson(),
        "seccion": seccion.toJson(),
        "ciclo": ciclo.toJson(),
    };
}
