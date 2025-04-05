class StudentPaymentModelClass {
  final bool? error;
  final String? status;

  StudentPaymentModelClass({
    this.error,
    this.status,
  });

  StudentPaymentModelClass.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?;

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status
  };
}