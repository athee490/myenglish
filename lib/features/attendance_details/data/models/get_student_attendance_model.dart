class GetStudentAttendanceModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<GetStudentData>? data;

  GetStudentAttendanceModel({
    this.error,
    this.status,
    this.message,
    this.data,
  });

  GetStudentAttendanceModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => GetStudentData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class GetStudentData {
  final String? studentId;
  final String? name;
  final String? courseStartTime;
  final String? courseEndTime;
  final dynamic profileImage;
  final List<AttendanceData>? attendance;

  GetStudentData({
    this.studentId,
    this.name,
    this.courseStartTime,
    this.courseEndTime,
    this.profileImage,
    this.attendance,
  });

  GetStudentData.fromJson(Map<String, dynamic> json)
      : studentId = json['studentId'] as String?,
        name = json['name'] as String?,
        courseStartTime = json['courseStartTime'] as String?,
        courseEndTime = json['courseEndTime'] as String?,
        profileImage = json['profileImage'],
        attendance = (json['attendance'] as List?)?.map((dynamic e) => AttendanceData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'studentId' : studentId,
    'name' : name,
    'courseStartTime' : courseStartTime,
    'courseEndTime' : courseEndTime,
    'profileImage' : profileImage,
    'attendance' : attendance?.map((e) => e.toJson()).toList()
  };
}

class AttendanceData {
  final int? currentDay;
  final int? presentsMinutes;
  final String? dayName;
  final String? todayDate;
  final int? studentAttendance;
  final int? tutorAttendance;

  AttendanceData({
    this.currentDay,
    this.presentsMinutes,
    this.dayName,
    this.todayDate,
    this.studentAttendance,
    this.tutorAttendance
  });

  AttendanceData.fromJson(Map<String, dynamic> json)
      : currentDay = json['currentDay'] as int?,
        presentsMinutes = json['presentsMinutes'] as int?,
        dayName = json['dayName'] as String?,
        todayDate = json['todayDate'] as String?,
        studentAttendance = json['studentAttendance'] as int?,
        tutorAttendance = json['tutorAttendance'] as int?;

  Map<String, dynamic> toJson() => {
    'currentDay' : currentDay,
    'presentsMinutes' : presentsMinutes,
    'dayName' : dayName,
    'todayDate' : todayDate
  };
}