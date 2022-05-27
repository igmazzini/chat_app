// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/user.dart';

UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
    UsersResponse({
        required this.ok,
        required this.users,
        required this.msg,
        required this.from,
        required this.to,
    });

    bool ok;
    List<User> users;
    String msg;
    int from;
    int to;

    factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        msg: json["msg"],
        from: json["from"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "msg": msg,
        "from": from,
        "to": to,
    };
}

