// To parse this JSON data, do
//
//     final resourceModel = resourceModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:video_player/video_player.dart';

ResourceModel resourceModelFromJson(String str) =>
    ResourceModel.fromJson(json.decode(str));

String resourceModelToJson(ResourceModel data) => json.encode(data.toJson());

class ResourceModel {
  ResourceModel({
    this.totalCount,
    this.data,
  });

  TotalCount? totalCount;
  List<ResourceDatum>? data;

  factory ResourceModel.fromJson(Map<String, dynamic> json) => ResourceModel(
        totalCount: json["totalCount"] == null
            ? null
            : TotalCount.fromJson(json["totalCount"]),
        data: json["data"] == null
            ? null
            : List<ResourceDatum>.from(
                json["data"].map((x) => ResourceDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ResourceDatum extends Equatable {
  ResourceDatum({
    this.id,
    this.file,
    this.fileType,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.courseLevel,
    this.title,
    this.language,
    this.videoPlayerController,
  });

  int? id;
  String? file;
  String? fileType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;
  String? courseLevel;
  String? title;
  String? language;
  VideoPlayerController? videoPlayerController;

  factory ResourceDatum.fromJson(Map<String, dynamic> json) => ResourceDatum(
        id: json["id"],
        file: json["file"],
        fileType: json["fileType"],
        createdAt: DateTime.tryParse(json["createdAt"]),
        updatedAt: DateTime.tryParse(json["updatedAt"]),
        isActive: json["isActive"],
        courseLevel: json["courseLevel"],
        title: toTitleCase(json["title"] ?? 'title'),
        language: json['language'] ?? 'english',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "fileType": fileType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActive": isActive,
        "courseLevel": courseLevel,
        "title": title,
        "language": language,
      };

  @override
  List<Object?> get props => [
        id,
        file,
        fileType,
        createdAt,
        updatedAt,
        isActive,
        courseLevel,
        title,
        language,
        videoPlayerController
      ];
}

class TotalCount {
  TotalCount({
    required this.currentPage,
    required this.totalCount,
    required this.totalPages,
  });

  String currentPage;
  int totalCount;
  int totalPages;

  factory TotalCount.fromJson(Map<String, dynamic> json) => TotalCount(
        currentPage: json["currentPage"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalCount": totalCount,
        "totalPages": totalPages,
      };
}
