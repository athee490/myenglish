// To parse this JSON data, do
//
//     final tutorDashboardModel = tutorDashboardModelFromJson(jsonString);

import 'dart:convert';

TutorDashboardModel tutorDashboardModelFromJson(String str) =>
    TutorDashboardModel.fromJson(json.decode(str));

String tutorDashboardModelToJson(TutorDashboardModel data) =>
    json.encode(data.toJson());

class TutorDashboardModel {
  TutorDashboardModel({
    this.dashboardDetails,
    this.liveDetails,
  });

  List<TutorDashboardDetail>? dashboardDetails;
  List<TutorLiveDetail>? liveDetails;

  factory TutorDashboardModel.fromJson(Map<String, dynamic> json) =>
      TutorDashboardModel(
        dashboardDetails: json["dashboardDetails"] == null
            ? []
            : List<TutorDashboardDetail>.from(json["dashboardDetails"]
                .map((x) => TutorDashboardDetail.fromJson(x))),
        liveDetails: json["liveDetails"] == null
            ? null
            : List<TutorLiveDetail>.from(
                json["liveDetails"].map((x) => TutorLiveDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dashboardDetails":
            List<dynamic>.from(dashboardDetails!.map((x) => x.toJson())),
        "liveDetails": List<dynamic>.from(liveDetails!.map((x) => x.toJson())),
      };
}

class TutorDashboardDetail {
  TutorDashboardDetail({
    this.studentsAssigned = 0,
    this.classesConducted = 0,
    this.salary = 0,
    this.tutorName,
    this.tutorImage,
    this.id,
    this.firebaseId,
    this.verified = false,
  });

  int? studentsAssigned;
  int? classesConducted;
  int? salary;
  String? tutorName;
  String? tutorImage;
  int? id;
  String? firebaseId;
  bool? verified;

  factory TutorDashboardDetail.fromJson(Map<String, dynamic> json) =>
      TutorDashboardDetail(
        studentsAssigned: json["studentsAssigned"] ?? 0,
        classesConducted: json["classesConducted"] ?? 0,
        salary: json["salary"] ?? 0,
        tutorName: json["tutorName"],
        tutorImage: json["tutorImage"],
        id: json["id"],
        verified: (json['verified'] ?? 0) == 1,
        firebaseId: json["firebase_id"],
      );

  Map<String, dynamic> toJson() => {
        "studentsAssigned": studentsAssigned,
        "classesConducted": classesConducted,
        "tutorName": tutorName,
        "tutorImage": tutorImage,
        "id": id,
        "firebase_id": firebaseId,
        "verified": verified,
      };
}

class TutorLiveDetail {
  TutorLiveDetail({
    this.attendance,
    this.planDuration,
    this.id,
    this.studentId,
    this.tutorId,
    this.topicName,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.callId,
    this.token,
    this.duration,
    this.tutorName,
    this.studentName,
    this.studentStatus,
    this.profileImage,
    this.totalClassCount,
  });

  int? attendance;
  dynamic planDuration;
  int? id;
  int? studentId;
  int? tutorId;
  dynamic topicName;
  DateTime? fromDate;
  DateTime? toDate;
  String? fromTime;
  String? toTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? isActive;
  String? callId;
  String? token;
  String? duration;
  String? tutorName;
  String? studentName;
  int? studentStatus;
  String? profileImage;
  int? totalClassCount;

  factory TutorLiveDetail.fromJson(Map<String, dynamic> json) =>
      TutorLiveDetail(
        attendance: json["attendance"],
        planDuration: json["planDuration"],
        id: json["id"],
        studentId: json["studentId"],
        tutorId: json["tutorId"],
        topicName: json["topicName"],
        fromDate: DateTime.tryParse(json["fromDate"] ?? ''),
        toDate: DateTime.tryParse(json["toDate"] ?? ''),
        fromTime: json["fromTime"],
        toTime: json["toTime"],
        createdAt: DateTime.tryParse(json["createdAt"] ?? ''),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? ''),
        isActive: json["isActive"],
        callId: json["call_id"],
        token: json["agoraToken"],
        duration: json["duration"],
        tutorName: json["tutorName"],
        studentName: json["studentName"],
        studentStatus: json["studentStatus"],
        profileImage: json["profile_image"],
        totalClassCount: json['totalClassCount'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "attendance": attendance,
        "planDuration": planDuration,
        "id": id,
        "studentId": studentId,
        "tutorId": tutorId,
        "topicName": topicName,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "fromTime": fromTime,
        "toTime": toTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActive": isActive,
        "call_id": callId,
        "agoraToken": token,
        "duration": duration,
        "tutorName": tutorName,
        "studentName": studentName,
        "studentStatus": studentStatus,
        "profile_image": profileImage,
        "totalClassCount": totalClassCount,
      };
}
