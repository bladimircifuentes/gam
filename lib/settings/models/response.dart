// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    bool result;
    String message;
    List<dynamic> records;

    ResponseModel({
        required this.result,
        required this.message,
        required this.records,
    });

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        result: json["result"],
        message: json["message"],
        records: List<dynamic>.from(json["records"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "records": List<dynamic>.from(records.map((x) => x)),
    };
}
