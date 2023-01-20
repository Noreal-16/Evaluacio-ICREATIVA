import 'dart:convert';

import 'package:notes_app/models/model_user.dart';

class ResponseLogin {
  ResponseLogin({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory ResponseLogin.fromJson(String str) => ResponseLogin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseLogin.fromMap(Map<String, dynamic> json) => ResponseLogin(
    user: json["user"] == null ? null : User.fromMap(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "user": user?.toMap(),
    "token": token,
  };
}