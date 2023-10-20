class CicloModel {
    int id;
    int ciclo;
    int activo;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    CicloModel({
        required this.id,
        required this.ciclo,
        required this.activo,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory CicloModel.fromJson(Map<String, dynamic> json) => CicloModel(
        id: json["id"],
        ciclo: json["ciclo"],
        activo: json["activo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ciclo": ciclo,
        "activo": activo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
