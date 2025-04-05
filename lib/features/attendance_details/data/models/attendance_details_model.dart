class AttendanceDetail {
  AttendanceDetail({
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
    this.duration,
    this.studentAttendance,
    this.tutorAttendance,
  });

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
  String? duration;
  int? studentAttendance;
  int? tutorAttendance;

  factory AttendanceDetail.fromJson(Map<String, dynamic> json) =>
      AttendanceDetail(
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
        duration: (json["duration"] ?? '').toString(),
        studentAttendance: json["studentAttendance"],
        tutorAttendance: json["tutorAttendance"],
      );

  Map<String, dynamic> toJson() => {
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
        "duration": duration,
        "studentAttendance": studentAttendance,
        "tutorAttendance": tutorAttendance,
      };
}
