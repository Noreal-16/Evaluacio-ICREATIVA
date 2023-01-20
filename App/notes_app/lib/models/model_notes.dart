import 'dart:convert';

class Notes {
  Notes({
    this.id,
    this.description,
    this.completed,
    this.active,
  });

  int? id;
  String? description;
  bool? completed;
  bool? active;

  factory Notes.fromJson(String str) => Notes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notes.fromMap(Map<String, dynamic> json) => Notes(
    id: json["id"],
    description: json["description"],
    completed: json["completed"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "description": description,
    "completed": completed,
    "active": active,
  };
}