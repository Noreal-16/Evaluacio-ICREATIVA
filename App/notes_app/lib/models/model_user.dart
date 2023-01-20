import 'dart:convert';

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.dateUpdate,
  });

  int? id;
  String? name;
  String? email;
  String? password;
  String? dateUpdate;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    dateUpdate: json["date_update"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "date_update": dateUpdate,
  };

  User.map(dynamic obj){
    id= obj["id"];
    name= obj["name"];
    email= obj["email"];
    password= obj["password"];
    dateUpdate= obj["date_update"];
  }
}
