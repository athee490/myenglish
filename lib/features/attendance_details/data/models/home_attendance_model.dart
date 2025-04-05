// To parse this JSON data, do
//
//     final homeAttendanceModel = homeAttendanceModelFromJson(jsonString);

import 'dart:convert';

import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';

HomeAttendanceModel? homeAttendanceModelFromJson(String str) =>
    HomeAttendanceModel.fromJson(json.decode(str));

String homeAttendanceModelToJson(HomeAttendanceModel? data) =>
    json.encode(data!.toJson());

class HomeAttendanceModel {
  HomeAttendanceModel({
    this.studentId,
    this.name,
    this.profileImage,
    this.isActive,
    this.courseId,
    this.tutorId,
    this.courseStartDate,
    this.courseEndDate,
    this.courseFromTime,
    this.courseToTime,
    this.classDuration,
    this.planDuration,
    this.attendanceDetails = const [],
  });

  String? studentId;
  String? name;
  String? profileImage;
  int? isActive;
  int? courseId;
  int? tutorId;
  DateTime? courseStartDate;
  DateTime? courseEndDate;
  String? courseFromTime;
  String? courseToTime;
  String? classDuration;
  String? planDuration;
  List<AttendanceDetail?> attendanceDetails;

  factory HomeAttendanceModel.fromJson(Map<String, dynamic> json) =>
      HomeAttendanceModel(
        studentId: json["studentId"],
        name: json["name"],
        profileImage: json["profile_image"],
        isActive: json["isActive"],
        courseId: json["courseId"],
        tutorId: json["tutorId"],
        courseStartDate:
            DateTime.tryParse(json["courseStartDate"] ?? '') ?? DateTime.now(),
        courseEndDate: DateTime.tryParse(json["courseEndDate"] ?? ''),
        courseFromTime: json["courseFromTime"],
        courseToTime: json["courseToTime"],
        classDuration: json["classDuration"],
        planDuration: json["planDuration"],
        attendanceDetails: json["attendanceDetails"] == null
            ? []
            : List<AttendanceDetail?>.from(json["attendanceDetails"]!
                .map((x) => AttendanceDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
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
        "attendanceDetails":
            List<dynamic>.from(attendanceDetails.map((x) => x!.toJson())),
      };
}
