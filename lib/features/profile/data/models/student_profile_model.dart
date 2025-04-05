class StudentProfileModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<StudentProfileDetails>? data;

  StudentProfileModel({
    this.error,
    this.status,
    this.message,
    this.data,
  });

  StudentProfileModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) =>
                StudentProfileDetails.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'error': error,
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class StudentProfileDetails {
  final String? name;
  final String? phoneNumber;
  final String? phoneCode;
  final String? country;
  final dynamic fbId;
  final String? userId;
  final String? enrollment;
  final String? grade;
  final String? password;
  final String? createdAt;
  final String? email;
  final int? id;
  final dynamic deviceToken;
  final int? isActive;
  final String? otp;
  final dynamic profileImage;

  StudentProfileDetails({
    this.name,
    this.phoneNumber,
    this.phoneCode,
    this.country,
    this.fbId,
    this.userId,
    this.enrollment,
    this.grade,
    this.password,
    this.createdAt,
    this.email,
    this.id,
    this.deviceToken,
    this.isActive,
    this.otp,
    this.profileImage,
  });

  StudentProfileDetails.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        phoneCode = json['phoneCode'] as String?,
        country = json['country'] as String?,
        fbId = json['fbId'],
        userId = json['userId'] as String?,
        enrollment = json['enrollment'] as String?,
        grade = json['grade'] as String?,
        password = json['password'] as String?,
        createdAt = json['createdAt'] as String?,
        email = json['email'] as String?,
        id = json['id'] as int?,
        deviceToken = json['deviceToken'],
        isActive = json['isActive'] as int?,
        otp = json['otp'] as String?,
        profileImage = json['profileImage'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'phoneCode': phoneCode,
        'country': country,
        'fbId': fbId,
        'userId': userId,
        'enrollment': enrollment,
        'grade': grade,
        'password': password,
        'createdAt': createdAt,
        'email': email,
        'id': id,
        'deviceToken': deviceToken,
        'isActive': isActive,
        'otp': otp,
        'profileImage': profileImage
      };
}
