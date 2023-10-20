import 'package:gam/common/models/models.dart';

class PayloadModel {
    LoggedModel logged;
    String accessToken;
    String tokenType;
    int expiresIn;

    PayloadModel({
        required this.logged,
        required this.accessToken,
        required this.tokenType,
        required this.expiresIn,
    });

    factory PayloadModel.fromJson(Map<String, dynamic> json) => PayloadModel(
        logged: LoggedModel.fromJson(json["logged"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "logged": logged.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
    };
}