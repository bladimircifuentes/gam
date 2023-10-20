// To parse this JSON data, do
//
//     final Application = applicationDtoFromJson(jsonString);

import 'dart:convert';

Application applicationFromJson(String str) => Application.fromJson(json.decode(str));

String applicationToJson(Application data) => json.encode(data.toJson());

class Application {
    int applicationId;
    String description;
    String type;

    Application({
        required this.applicationId,
        required this.description,
        required this.type,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        applicationId: json["applicationId"],
        description: json["description"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "description": description,
        "type": type,
    };
}
