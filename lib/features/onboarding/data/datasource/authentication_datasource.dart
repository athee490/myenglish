import 'dart:io';

import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class AuthenticationDataSource {
  ///student login
  Future<Either<Failure, String>> studentLogin(String email, String password);

  ///api to update device token
  Future<Either<Failure, bool>> updateDeviceToken(String fcmToken);

  ///student register
  Future<Either<Failure, String>> studentRegister({
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneCode,
    required String password,
    required String enrollment,
    required String grade,
    required String country,


    // required String dob,
    // required String startDate,
    // required String firebaseId,
    // required String deviceToken,
    // required String pincode,
    // required String reason,
    // required String language,
    // required String occupation,
    // required String qualification,
    // required String goalToJoin,
    // required String fromTime,
    // required String toTime,
  });

  ///tutor login
  Future<Either<Failure, String>> tutorLogin(String email, String password);

  ///tutor register
  Future<Either<Failure, String>> tutorRegister({
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneCode,
    required String videoResume,
    required String password,
    required String occupation,
    required String education,
    required String country,
    required String documentType,
    required String documentLink,
    required String bankName,
    required String ifsc,
    required String userName,
    required String bankAccountNumber
  });

  ///send otp
  Future<Either<Failure, String>> sendOtp(String email, int userType);

  ///verify otp
  Future<Either<Failure, bool>> verifyOtp(
      String email, String otp, int userType);

  ///reset password
  Future<Either<Failure, bool>> resetPassword(
      String email, String password, int userType);

  ///file upload
  Future<Either<Failure, String>> fileUpload(File file);

  ///update payment status
  Future<Either<Failure, bool>> updatePaymentStatus(
      {required String planDuration,
      required String amount,
      required String classDuration,
      required String razorpayId,
      required bool extend});
}
