class GetTutorStatisticsModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<TutorStatisticsData>? data;

  GetTutorStatisticsModel({
    this.error,
    this.status,
    this.message,
    this.data,
  });

  GetTutorStatisticsModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => TutorStatisticsData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class TutorStatisticsData {
  final String? userId;
  final String? name;
  final int? totalStudentsEnrolled;
  final int? totalClassesConducted;

  TutorStatisticsData({
    this.userId,
    this.name,
    this.totalStudentsEnrolled,
    this.totalClassesConducted,
  });

  TutorStatisticsData.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as String?,
        name = json['name'] as String?,
        totalStudentsEnrolled = json['totalStudentsEnrolled'] as int?,
        totalClassesConducted = json['totalClassesConducted'] as int?;

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'name' : name,
    'totalStudentsEnrolled' : totalStudentsEnrolled,
    'totalClassesConducted' : totalClassesConducted
  };
}