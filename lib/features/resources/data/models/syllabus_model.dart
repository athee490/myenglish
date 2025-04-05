import 'dart:convert';

SyllabusModel? syllabusModelFromJson(String str) =>
    SyllabusModel.fromJson(json.decode(str));

String syllabusModelToJson(SyllabusModel? data) => json.encode(data!.toJson());

class SyllabusModel {
  SyllabusModel({
    this.id,
    this.name,
    this.courseLevel,
    this.syllabus,
    this.createdAt,
    this.updatedAt,
    this.isActive,
  });

  int? id;
  dynamic name;
  String? courseLevel;
  String? syllabus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;

  factory SyllabusModel.fromJson(Map<String, dynamic> json) => SyllabusModel(
        id: json["id"],
        name: json["name"] ?? 'Title',
        courseLevel: json["courseLevel"],
        syllabus: json["syllabus"],
        createdAt: DateTime.tryParse(json["createdAt"] ?? ''),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? ''),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "courseLevel": courseLevel,
        "syllabus": syllabus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActive": isActive,
      };
}
