class GetTutorTodayCourseModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<TutorTodayCourseDetails>? data;

  GetTutorTodayCourseModel({
    this.error,
    this.status,
    this.message,
    this.data,
  });

  GetTutorTodayCourseModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => TutorTodayCourseDetails.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class TutorTodayCourseDetails {
  final int? id;
  final String? courseType;
  final String? title;
  final String? keyword;
  final String? courseIntro;
  final String? timezone;
  final String? syllabus;
  final String? shortDescription;
  final String? longDescription;
  final dynamic createdAt;
  final String? startDate;
  final String? endDate;
  final String? startTime;
  final String? endTime;
  final String? tutorId;
  final int? price;
  final int? isActive;
  final String? status;

  TutorTodayCourseDetails({
    this.id,
    this.courseType,
    this.title,
    this.keyword,
    this.courseIntro,
    this.timezone,
    this.syllabus,
    this.shortDescription,
    this.longDescription,
    this.createdAt,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.tutorId,
    this.price,
    this.isActive,
    this.status,
  });

  TutorTodayCourseDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        courseType = json['courseType'] as String?,
        title = json['title'] as String?,
        keyword = json['keyword'] as String?,
        courseIntro = json['courseIntro'] as String?,
        timezone = json['timezone'] as String?,
        syllabus = json['syllabus'] as String?,
        shortDescription = json['shortDescription'] as String?,
        longDescription = json['longDescription'] as String?,
        createdAt = json['createdAt'],
        startDate = json['startDate'] as String?,
        endDate = json['endDate'] as String?,
        startTime = json['startTime'] as String?,
        endTime = json['endTime'] as String?,
        tutorId = json['tutorId'] as String?,
        price = json['price'] as int?,
        isActive = json['isActive'] as int?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'courseType' : courseType,
    'title' : title,
    'keyword' : keyword,
    'courseIntro' : courseIntro,
    'timezone' : timezone,
    'syllabus' : syllabus,
    'shortDescription' : shortDescription,
    'longDescription' : longDescription,
    'createdAt' : createdAt,
    'startDate' : startDate,
    'endDate' : endDate,
    'startTime' : startTime,
    'endTime' : endTime,
    'tutorId' : tutorId,
    'price' : price,
    'isActive' : isActive,
    'status' : status
  };
}