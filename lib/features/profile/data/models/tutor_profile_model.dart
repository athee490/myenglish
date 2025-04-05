class TutorProfileModel {
  final bool? error;
  final String? status;
  final String? message;
  final List<TutorProfileDetails>? data;

  TutorProfileModel({
    this.error,
    this.status,
    this.message,
    this.data,
  });

  TutorProfileModel.fromJson(Map<String, dynamic> json)
      : error = json['error'] as bool?,
        status = json['status'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => TutorProfileDetails.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'error' : error,
    'status' : status,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class TutorProfileDetails {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? phoneCode;
  final String? country;
  final dynamic fbId;
  final String? userId;
  final dynamic enrollment;
  final String? education;
  final String? documentType;
  final String? occupation;
  final String? videoResume;
  final String? bankName;
  final String? userName;
  final String? ifsc;
  final String? accountNumber;
  final dynamic profileImage;
  final int? verified;
  final dynamic availableFromTime;
  final dynamic availableToTime;
  final int? isActive;
  final String? createdAt;
  final String? password;
  final String? documentLink;
  final dynamic bankAccountNumber;
  final int? id;
  final String? otp;

  TutorProfileDetails({
    this.name,
    this.phoneNumber,
    this.email,
    this.phoneCode,
    this.country,
    this.fbId,
    this.userId,
    this.enrollment,
    this.education,
    this.documentType,
    this.occupation,
    this.videoResume,
    this.bankName,
    this.userName,
    this.ifsc,
    this.accountNumber,
    this.profileImage,
    this.verified,
    this.availableFromTime,
    this.availableToTime,
    this.isActive,
    this.createdAt,
    this.password,
    this.documentLink,
    this.bankAccountNumber,
    this.id,
    this.otp,
  });

  TutorProfileDetails.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        phoneNumber = json['phoneNumber'] as String?,
        email = json['email'] as String?,
        phoneCode = json['phoneCode'] as String?,
        country = json['country'] as String?,
        fbId = json['fbId'],
        userId = json['userId'] as String?,
        enrollment = json['enrollment'],
        education = json['education'] as String?,
        documentType = json['documentType'] as String?,
        occupation = json['occupation'] as String?,
        videoResume = json['videoResume'] as String?,
        bankName = json['bankName'] as String?,
        userName = json['userName'] as String?,
        ifsc = json['ifsc'] as String?,
        accountNumber = json['accountNumber'] as String?,
        profileImage = json['profileImage'],
        verified = json['verified'] as int?,
        availableFromTime = json['availableFromTime'],
        availableToTime = json['availableToTime'],
        isActive = json['isActive'] as int?,
        createdAt = json['createdAt'] as String?,
        password = json['password'] as String?,
        documentLink = json['documentLink'] as String?,
        bankAccountNumber = json['bankAccountNumber'],
        id = json['id'] as int?,
        otp = json['otp'] as String?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'phoneNumber' : phoneNumber,
    'email' : email,
    'phoneCode' : phoneCode,
    'country' : country,
    'fbId' : fbId,
    'userId' : userId,
    'enrollment' : enrollment,
    'education' : education,
    'documentType' : documentType,
    'occupation' : occupation,
    'videoResume' : videoResume,
    'bankName' : bankName,
    'userName' : userName,
    'ifsc' : ifsc,
    'accountNumber' : accountNumber,
    'profileImage' : profileImage,
    'verified' : verified,
    'availableFromTime' : availableFromTime,
    'availableToTime' : availableToTime,
    'isActive' : isActive,
    'createdAt' : createdAt,
    'password' : password,
    'documentLink' : documentLink,
    'bankAccountNumber' : bankAccountNumber,
    'id' : id,
    'otp' : otp
  };
}