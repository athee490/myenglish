import 'dart:convert';

StudentDashboardModel studentDashboardModelFromJson(String str) =>
    StudentDashboardModel.fromJson(json.decode(str));

String studentDashboardModelToJson(StudentDashboardModel data) =>
    json.encode(data.toJson());

class StudentDashboardModel {
  StudentDashboardModel({
    this.dashboardDetails,
    this.liveDetails,
  });

  List<DashboardDetail>? dashboardDetails;
  List<LiveDetail>? liveDetails;

  factory StudentDashboardModel.fromJson(Map<String, dynamic> json) =>
      StudentDashboardModel(
        dashboardDetails: json["dashboardDetails"] == null
            ? null
            : List<DashboardDetail>.from(json["dashboardDetails"]
                .map((x) => DashboardDetail.fromJson(x))),
        liveDetails: json["liveDetails"] == null
            ? []
            : List<LiveDetail>.from(
                json["liveDetails"].map((x) => LiveDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dashboardDetails":
            List<dynamic>.from(dashboardDetails!.map((x) => x.toJson())),
        "liveDetails": List<dynamic>.from(liveDetails!.map((x) => x.toJson())),
      };
}

class DashboardDetail {
  DashboardDetail({
    this.classCount,
    this.tutorName,
    this.paid,
    this.courseLevel,
    this.tutorImage,
    this.id,
    this.firebaseId,
    this.name,
    this.profileImage,
    this.courseId,
    this.tutorId,
    this.courseStartDate,
    this.courseEndDate,
    this.courseFromTime,
    this.courseToTime,
    this.classDuration,
    this.planDuration,
    this.amountPaid,
  });

  int? classCount;
  String? tutorName;
  int? paid;
  String? courseLevel;
  String? tutorImage;
  int? id;
  String? firebaseId;
  String? name;
  String? profileImage;
  int? courseId;
  int? tutorId;
  DateTime? courseStartDate;
  DateTime? courseEndDate;
  String? courseFromTime;
  String? courseToTime;
  String? classDuration;
  String? planDuration;
  String? amountPaid;

  factory DashboardDetail.fromJson(Map<String, dynamic> json) =>
      DashboardDetail(
        classCount: json["classCount"],
        tutorName: json["tutorName"],
        paid: json["paid"] ?? 0,
        courseLevel: json["courseLevel"] != null
            ? json["courseLevel"].toString().toLowerCase() == 'beginner'
                ? 'Student'
                : 'Professional'
            : '',
        tutorImage: json["tutorImage"],
        id: json["id"],
        firebaseId: json["firebase_id"],
        name: json["name"],
        profileImage: json["profile_image"],
        courseId: json["courseId"] ?? 0,
        tutorId: json["tutorId"],
        courseStartDate: DateTime.tryParse(json["courseStartDate"] ?? ''),
        courseEndDate: DateTime.tryParse(json["courseEndDate"] ?? ''),
        courseFromTime: json["courseFromTime"],
        courseToTime: json["courseToTime"],
        classDuration: json["classDuration"],
        planDuration: json["planDuration"],
        amountPaid: json["amountPaid"],
      );

  Map<String, dynamic> toJson() => {
        "classCount": classCount,
        "tutorName": tutorName,
        "paid": paid,
        "courseLevel": courseLevel,
        "tutorImage": tutorImage,
        "id": id,
        "firebase_id": firebaseId,
        "name": name,
        "profile_image": profileImage,
        "courseId": courseId,
        "tutorId": tutorId,
        "courseStartDate": courseStartDate?.toIso8601String(),
        "courseEndDate": courseEndDate?.toIso8601String(),
        "courseFromTime": courseFromTime,
        "courseToTime": courseToTime,
        "classDuration": classDuration,
        "planDuration": planDuration,
        "amountPaid": amountPaid,
      };

  String totalDays() {
    switch (planDuration) {
      case '1 months':
        return '30';
      case '3 months':
        return '90';
      case '6 months':
        return '180';
      default:
        return '0';
    }
  }
}

class LiveDetail {
  LiveDetail({
    this.id,
    this.studentId,
    this.tutorId,
    this.topicName,
    this.tutorImage,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.callId = '',
    this.token = '',
    this.duration,
    this.tutorName,
    this.tutorActiveStatus,
    this.studentName,
    this.planDuration,
  });

  int? id;
  int? studentId;
  int? tutorId;
  dynamic topicName;
  String? tutorImage;
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
  int? tutorActiveStatus;
  String? studentName;
  String? planDuration;

  factory LiveDetail.fromJson(Map<String, dynamic> json) => LiveDetail(
        id: json["id"],
        studentId: json["studentId"],
        tutorId: json["tutorId"],
        topicName: json["topicName"],
        tutorImage: json["tutorImage"],
        fromDate: DateTime.tryParse(json["fromDate"] ?? ''),
        toDate: DateTime.tryParse(json["toDate"] ?? ''),
        fromTime: json["fromTime"],
        toTime: json["toTime"],
        createdAt: DateTime.tryParse(json["createdAt"] ?? ''),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? ''),
        isActive: json["isActive"],
        callId: json["call_id"] ?? '',
        duration: json["duration"],
        tutorName: json["tutorName"],
        tutorActiveStatus: json["tutorActiveStatus"] ?? 0,
        studentName: json["studentName"],
        token: json['agoraToken'] ?? '',
        planDuration: json['planDuration'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "tutorId": tutorId,
        "topicName": topicName,
        "tutorImage": tutorImage,
        "fromDate": fromDate?.toIso8601String(),
        "toDate": toDate?.toIso8601String(),
        "fromTime": fromTime,
        "toTime": toTime,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActive": isActive,
        "call_id": callId,
        "duration": duration,
        "tutorName": tutorName,
        "studentName": studentName,
        "agoraToken": token,
        "planDuration": planDuration,
      };
}
