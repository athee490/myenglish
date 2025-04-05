import 'dart:convert';

BreakoutRoomUser breakoutRoomUserFromJson(String str) =>
    BreakoutRoomUser.fromJson(json.decode(str));

String breakoutRoomUserToJson(BreakoutRoomUser data) =>
    json.encode(data.toJson());

class BreakoutRoomUser {
  BreakoutRoomUser({
    this.id,
    this.studentName,
    this.callId,
    this.userCount,
    this.userId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updateAt,
    this.isActive,
  });

  int? id;
  String? studentName;
  String? callId;
  int? userCount;
  int? userId;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? createdAt;
  DateTime? updateAt;
  int? isActive;

  factory BreakoutRoomUser.fromJson(Map<String, dynamic> json) =>
      BreakoutRoomUser(
        id: json["id"],
        studentName: json["studentName"] ?? '',
        callId: json["callId"],
        userCount: json["userCount"],
        userId: json["userId"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime: DateTime.tryParse(json["endTime"].toString()),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updateAt:
            json["updateAt"] == null ? null : DateTime.parse(json["updateAt"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentName": studentName,
        "callId": callId,
        "userCount": userCount,
        "userId": userId,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime,
        "createdAt": createdAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
        "isActive": isActive,
      };
}
