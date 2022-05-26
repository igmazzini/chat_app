// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/user.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        required this.ok,
        required this.msg,
        this.user,
        required this.token,
    });

    bool ok;
    String msg;
    User? user;
    String? token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
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

