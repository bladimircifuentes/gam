class Ciclo {
    int id;
    int ciclo;
    int activo;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Ciclo({
        required this.id,
        required this.ciclo,
        required this.activo,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Ciclo.fromJson(Map<String, dynamic> json) => Ciclo(
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
