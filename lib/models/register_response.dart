// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/user.dart';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
    RegisterResponse({
        required this.ok,
        required this.msg,
        this.user,
        this.token,
    });

    bool ok;
    String msg;
    User? user;
    String? token;

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        ok: json["ok"],
        msg: json["msg"],
        user: (json["user"] != null) ? User.fromJson(json["user"]) : null,
        token: (json["token"] != null) ? json["token"] : null,
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "user": (user == null ) ? null : user!.toJson(),
        "token": token,
    };
}


