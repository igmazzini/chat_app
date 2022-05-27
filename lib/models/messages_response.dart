// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {
    MessagesResponse({
        required this.ok,
        required this.messages,
        required this.msg,
        required this.uid,
        required this.to,
    });

    bool ok;
    List<Message> messages;
    String msg;
    String uid;
    String to;

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        msg: json["msg"],
        uid: json["uid"],
        to: json["to"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "msg": msg,
        "uid": uid,
        "to": to,
    };
}

class Message {
    Message({
        required this.from,
        required this.to,
        required this.msg,
        required this.createdAt,
        required this.updatedAt,
    });

    String from;
    String to;
    String msg;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
