class GetPurchasedCourseModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<GetStudentPurchasedCourseDetails>? result;

  GetPurchasedCourseModel({
    this.error,
    this.status,
    this.message,
    this.result,
  });

  GetPurchasedCourseModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        result = (json['result'] as List?)
            ?.map((dynamic e) => GetStudentPurchasedCourseDetails.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'error': error,
        'status': status,
        'message': message,
        'result': result?.map((e) => e.toJson()).toList()
      };
}

class GetStudentPurchasedCourseDetails {
  final String? courseTitle;
  final String? tutorName;
  final dynamic tutorProfile;
  final int? price;
  final int? enrollmentId;
  final int? courseId;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final int? courseDurationInDays;
  final int? currentDay;
  final int? courseDurationInMonths;
  final int? courseMinutesPerDay;

  GetStudentPurchasedCourseDetails({
    this.courseTitle,
    this.tutorName,
    this.tutorProfile,
    this.price,
    this.enrollmentId,
    this.courseId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.courseDurationInDays,
    this.currentDay,
    this.courseDurationInMonths,
    this.courseMinutesPerDay,
  });

  GetStudentPurchasedCourseDetails.fromJson(Map<String, dynamic> json)
      : courseTitle = json['courseTitle'] as String?,
        tutorName = json['tutorName'] as String?,
        tutorProfile = json['tutorProfile'],
        price = json['price'] as int?,
        enrollmentId = json['enrollmentId'] as int?,
        courseId = json['courseId'] as int?,
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        courseDurationInDays = json['courseDurationInDays'] as int?,
        currentDay = json['currentDay'] as int?,
        courseDurationInMonths = json['courseDurationInMonths'] as int?,
        courseMinutesPerDay = json['courseMinutesPerDay'] as int?;

  Map<String, dynamic> toJson() => {
        'courseTitle': courseTitle,
        'tutorName': tutorName,
        'tutorProfile': tutorProfile,
        'price': price,
        'enrollmentId': enrollmentId,
        'courseId': courseId,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'courseDurationInDays': courseDurationInDays,
        'currentDay': currentDay,
        'courseDurationInMonths': courseDurationInMonths,
        'courseMinutesPerDay': courseMinutesPerDay
      };
}
