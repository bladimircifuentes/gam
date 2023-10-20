// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

import 'package:gam/common/models/models.dart';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
    bool success;
    PayloadModel payload;

    ResponseModel({
        required this.success,
        required this.payload,
    });

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        success: json["success"],
        payload: PayloadModel.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "payload": payload.toJson(),
    };
}















