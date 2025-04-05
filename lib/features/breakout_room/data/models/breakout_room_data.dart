import 'dart:convert';

import 'package:equatable/equatable.dart';

BreakoutRoomData breakoutRoomDataFromJson(String str) =>
    BreakoutRoomData.fromJson(json.decode(str));

String breakoutRoomDataToJson(BreakoutRoomData data) =>
    json.encode(data.toJson());

class BreakoutRoomData extends Equatable {
  BreakoutRoomData({
    this.callId,
    this.topic,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.userCount,
    this.agoraToken,
  });

  int? callId;
  String? topic;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;
  int? userCount;
  String? agoraToken;

  factory BreakoutRoomData.fromJson(Map<String, dynamic> json) =>
      BreakoutRoomData(
        callId: json["id"] ?? '',
        topic: json["name"] ?? '',
        createdAt: DateTime.tryParse(json["createdAt"] ?? ''),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? ''),
        isActive: json["isActive"],
        userCount: json["userCount"] ?? 0,
        agoraToken: json["agoraToken"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": callId,
        "name": topic,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActive": isActive,
        "userCount": userCount,
        "agoraToken": agoraToken,
      };

  @override
  List<Object?> get props => [callId, topic, agoraToken];
}
