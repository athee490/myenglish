// To parse this JSON data, do
//
//     final bRoomEnabledModel = bRoomEnabledModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<BRoomEnabledModel> bRoomEnabledModelFromJson(String str) =>
    List<BRoomEnabledModel>.from(
        json.decode(str).map((x) => BRoomEnabledModel.fromJson(x)));

String bRoomEnabledModelToJson(List<BRoomEnabledModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BRoomEnabledModel {
  BRoomEnabledModel({
    this.id = 0,
    this.days,
    this.enable = false,
    this.fromTime = '',
    this.toTime = '',
    this.createdAt,
    this.updatedAt,
    this.isClassTimeNow = false,
  });

  int? id;
  String? days;
  bool? enable;
  DateTime? createdAt;
  String? fromTime;
  String? toTime;
  DateTime? updatedAt;
  bool? isClassTimeNow;

  factory BRoomEnabledModel.fromJson(Map<String, dynamic> json) {
    final fromTime24Hrs = DateFormat('HH:mm').parse(json["fromTime"]);
    final fromTime12Hrs = DateFormat('h:mm a').format(fromTime24Hrs);
    final toTime24Hrs = DateFormat('HH:mm').parse(json["toTime"]);
    final toTime12Hrs = DateFormat('h:mm a').format(toTime24Hrs);

    //To check current time falls between fromTime and toTime
    DateTime currentTime = DateTime.now();
    DateTime fromTime = DateFormat('yyyy-MM-dd HH:mm').parse(
        '${DateFormat('yyyy-MM-dd').format(currentTime)} ${json["fromTime"]}');
    DateTime toTime = DateFormat('yyyy-MM-dd HH:mm').parse(
        '${DateFormat('yyyy-MM-dd').format(currentTime)} ${json["toTime"]}');

    return BRoomEnabledModel(
        id: json["id"] ?? 0,
        days: json["days"] ?? '',
        enable: json["enable"] == 1 ? true : false,
        fromTime: fromTime12Hrs ?? '',
        toTime: toTime12Hrs ?? '',
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isClassTimeNow:
            currentTime.isAfter(fromTime) && currentTime.isBefore(toTime));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "days": days,
        "enable": enable,
        "fromTime": fromTime,
        "toTime": toTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
