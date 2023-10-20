class PaisModel {
    int id;
    String? letra;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String? descripcion;

    PaisModel({
        required this.id,
        this.letra,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        this.descripcion,
    });

    factory PaisModel.fromJson(Map<String, dynamic> json) => PaisModel(
        id: json["id"],
        letra: json["letra"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        descripcion: json["descripcion"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "letra": letra,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "descripcion": descripcion,
    };
}