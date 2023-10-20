import 'package:gam/common/models/models.dart';

class LoggedModel {
    int id;
    int municipioId;
    String firstName;
    String lastName;
    String email;
    DateTime fechaNacimiento;
    String telefonos;
    String direccion;
    String cui;
    dynamic noIgss;
    String carnet;
    dynamic foto;
    int genero;
    dynamic religion;
    dynamic datosVarios;
    int role;
    int disciplinaTempt;
    dynamic token;
    int online;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int edad;
    String nombreCompleto;
    String idhash;
    String sexo;
    String pathProfile;
    List<PhoneModel> phones;
    String barCode;
    String fullAddress;
    String shortName;
    List<dynamic> docenteCursos;
    List<InscriptionModel> inscriptions;
    MunicipioModel municipio;

    LoggedModel({
        required this.id,
        required this.municipioId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.fechaNacimiento,
        required this.telefonos,
        required this.direccion,
        required this.cui,
        required this.noIgss,
        required this.carnet,
        required this.foto,
        required this.genero,
        required this.religion,
        required this.datosVarios,
        required this.role,
        required this.disciplinaTempt,
        required this.token,
        required this.online,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.edad,
        required this.nombreCompleto,
        required this.idhash,
        required this.sexo,
        required this.pathProfile,
        required this.phones,
        required this.barCode,
        required this.fullAddress,
        required this.shortName,
        required this.docenteCursos,
        required this.inscriptions,
        required this.municipio,
    });

    factory LoggedModel.fromJson(Map<String, dynamic> json) => LoggedModel(
        id: json["id"],
        municipioId: json["municipio_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        telefonos: json["telefonos"],
        direccion: json["direccion"],
        cui: json["cui"],
        noIgss: json["no_igss"],
        carnet: json["carnet"],
        foto: json["foto"],
        genero: json["genero"],
        religion: json["religion"],
        datosVarios: json["datos_varios"],
        role: json["role"],
        disciplinaTempt: json["disciplina_tempt"],
        token: json["token"],
        online: json["online"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        edad: json["edad"],
        nombreCompleto: json["nombre_completo"],
        idhash: json["idhash"],
        sexo: json["sexo"],
        pathProfile: json["path_profile"],
        phones: List<PhoneModel>.from(json["phones"].map((x) => PhoneModel.fromJson(x))),
        barCode: json["bar_code"],
        fullAddress: json["full_address"],
        shortName: json["short_name"],
        docenteCursos: List<dynamic>.from(json["docente_cursos"].map((x) => x)),
        inscriptions: List<InscriptionModel>.from(json["inscriptions"].map((x) => InscriptionModel.fromJson(x))),
        municipio: MunicipioModel.fromJson(json["municipio"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "municipio_id": municipioId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "fecha_nacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "telefonos": telefonos,
        "direccion": direccion,
        "cui": cui,
        "no_igss": noIgss,
        "carnet": carnet,
        "foto": foto,
        "genero": genero,
        "religion": religion,
        "datos_varios": datosVarios,
        "role": role,
        "disciplina_tempt": disciplinaTempt,
        "token": token,
        "online": online,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "edad": edad,
        "nombre_completo": nombreCompleto,
        "idhash": idhash,
        "sexo": sexo,
        "path_profile": pathProfile,
        "phones": List<dynamic>.from(phones.map((x) => x.toJson())),
        "bar_code": barCode,
        "full_address": fullAddress,
        "short_name": shortName,
        "docente_cursos": List<dynamic>.from(docenteCursos.map((x) => x)),
        "inscriptions": List<dynamic>.from(inscriptions.map((x) => x.toJson())),
        "municipio": municipio.toJson(),
    };
}
