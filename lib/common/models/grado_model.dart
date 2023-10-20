class GradoModel {
    int id;
    String nombre;
    String descripcion;
    int nivel;
    int activo;
    int aceptaMenores;
    bool esSemestral;
    int minCursosPerder;
    int cantidadIngresoNotas;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    String descripcionNivel;

    GradoModel({
        required this.id,
        required this.nombre,
        required this.descripcion,
        required this.nivel,
        required this.activo,
        required this.aceptaMenores,
        required this.esSemestral,
        required this.minCursosPerder,
        required this.cantidadIngresoNotas,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.descripcionNivel,
    });

    factory GradoModel.fromJson(Map<String, dynamic> json) => GradoModel(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        nivel: json["nivel"],
        activo: json["activo"],
        aceptaMenores: json["acepta_menores"],
        esSemestral: json["es_semestral"],
        minCursosPerder: json["min_cursos_perder"],
        cantidadIngresoNotas: json["cantidad_ingreso_notas"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        descripcionNivel: json["descripcion_nivel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "nivel": nivel,
        "activo": activo,
        "acepta_menores": aceptaMenores,
        "es_semestral": esSemestral,
        "min_cursos_perder": minCursosPerder,
        "cantidad_ingreso_notas": cantidadIngresoNotas,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "descripcion_nivel": descripcionNivel,
    };
}