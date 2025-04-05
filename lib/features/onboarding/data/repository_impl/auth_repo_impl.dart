import 'dart:io';

import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/onboarding/data/datasource/authentication_datasource.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _dataSource;

  AuthenticationRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String>> studentLogin(
      String email, String password) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.studentLogin(email, password);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> studentRegister({
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneCode,
    required String password,
    required String enrollment,
    required String grade,
    required String country,
  }) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.studentRegister(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      phoneCode: phoneCode,
      password: password,
      enrollment: enrollment,
      grade: grade,
      country: country,
    );
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> updateDeviceToken(String fcmToken) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.updateDeviceToken(fcmToken);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> tutorLogin(
      String email, String password) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.tutorLogin(email, password);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> tutorRegister(
      {required String name,
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
      required String bankAccountNumber}) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.tutorRegister(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      phoneCode: phoneCode,
      videoResume: videoResume,
      password: password,
      occupation: occupation,
      education: education,
      country: country,
      documentType: documentType,
      documentLink: documentLink,
      bankName: bankName,
      ifsc: ifsc,
      userName: userName,
      bankAccountNumber: bankAccountNumber,
    );
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      String email, String password, int userType) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.resetPassword(email, password, userType);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> sendOtp(String email, int userType) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.sendOtp(email, userType);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(
      String email, String otp, int userType) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.verifyOtp(email, otp, userType);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> fileUpload(File file) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.fileUpload(file);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> updatePaymentStatus(
      {required String planDuration,
      required String amount,
      required String classDuration,
      required String razorpayId,
      required bool extend}) async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.updatePaymentStatus(
        planDuration: planDuration,
        amount: amount,
        classDuration: classDuration,
        razorpayId: razorpayId,
        extend: extend);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
