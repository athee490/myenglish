class TutorCourseRegistrationModel {
  final bool? error;
  final String? status;
  final String? message;

  TutorCourseRegistrationModel({
    this.error,
    this.status,
    this.message,
  });

  TutorCourseRegistrationModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message
  };
}