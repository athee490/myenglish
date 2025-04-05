class EditTutorCourseModel {
  final bool? error;
  final String? status;
  final String? message;

  EditTutorCourseModel({
    this.error,
    this.status,
    this.message,
  });

  EditTutorCourseModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message
  };
}