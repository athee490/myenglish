import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/onboarding/data/datasource/authentication_datasource.dart';

class AuthDataSourceImpl implements AuthenticationDataSource {
  final Dio dio;
  final FirebaseAuth firebaseAuth;

  AuthDataSourceImpl(this.dio, this.firebaseAuth);

  @override
  Future<Either<Failure, String>> studentLogin(
      String email, String password) async {
    var result = Either<Failure, String>();
    var body = {'email': email, 'password': password};
    try {
      var rawResponse = await dio.post(UrlConstants.loginStudent,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          var responseModel = (jsonData['token'] ?? '').toString();
          if (responseModel.trim().isEmpty) {
            result.setLeft(UnknownError());
          } else {
            result.setRight(responseModel);
          }
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> studentRegister(
      {required String name,
      required String email,
      required String phoneNumber,
      required String phoneCode,
      required String password,
      required String enrollment,
      required String grade,
      required String country,
      }) async {
    var result = Either<Failure, String>();

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.toString());
      print('token ${value.credential?.token}');
      print('uid ${value.user?.uid}');
      // firebaseId = value.user?.uid ?? '';
    }).catchError((e) {
      print('212121 e $e');
      if (e is FirebaseAuthException) {
        result.setLeft(CustomError(e.message));
        return;
      } else {
        result.setLeft(CustomError(e.toString()));
        return;
      }
    });
    // if (firebaseId != '') {
      var body = {//string
        'name': name,
        'email': email, //string
        'phoneNumber': phoneNumber,
        'phoneCode':phoneCode,
        'password': password, //string
        'enrollment': enrollment, //string
        'country': country, //string
        'grade':grade //string
      };

      print(body);
      try {
        var rawResponse = await dio.post(UrlConstants.registerStudent,
            data: body,
            options: Options(contentType: Headers.formUrlEncodedContentType));
        var response = await rawResponse.getResult();
        if (response.isLeft()) {
          result.setLeft(response.getLeft());
        } else {
          var jsonData = json.decode(response.getRight());
          log(jsonData.toString());
          if (jsonData['error']) {
            result.setLeft(CustomError(
                (jsonData['msg'] ?? jsonData['message']).toString()));
          } else {
            var responseModel = (jsonData['token'] ?? '').toString();
            if (responseModel.trim().isEmpty) {
              result.setLeft(UnknownError());
            } else {
              result.setRight(responseModel);
            }
          }
        }
      } on Exception catch (e) {
        if (e is DioError) {
          result.setLeft(e.getDioError());
        } else {
          result.setLeft(CustomError(e.toString()));
        }
      }
    // }
    return result;
  }

  @override
  Future<Either<Failure, bool>> updateDeviceToken(String fcmToken) async {
    var result = Either<Failure, bool>();
    var body = {'deviceToken': fcmToken};
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    print('212121 updateDeviceToken header $header');
    print('212121 updateDeviceToken params $body');

    try {
      var rawResponse = await dio.post(UrlConstants.deviceToken,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      print('212121 updateDeviceToken response $rawResponse');
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        print(response.getRight());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> tutorLogin(
      String email, String password) async {
    var result = Either<Failure, String>();
    var body = {'email': email, 'password': password};
    try {
      var rawResponse = await dio.post(UrlConstants.loginTutor,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          var responseModel = (jsonData['token'] ?? '').toString();
          if (responseModel.trim().isEmpty) {
            result.setLeft(UnknownError());
          } else {
            result.setRight(responseModel);
          }
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
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

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.toString());
      print('token ${value.credential?.token}');
      print('uid ${value.user?.uid}');
      // firebaseId = value.user?.uid ?? '';
    }).catchError((e) {
      if (e is FirebaseAuthException) {
        result.setLeft(CustomError(e.message));
      } else {
        result.setLeft(CustomError(e.toString()));
      }
      return;
    });
    // if (firebaseId != '') {
      var body = {
        // 'firebase_id': firebaseId, //string
        'name': name,
        'email': email, //string
        'phoneNumber': phoneNumber, //string
        'phoneCode': phoneCode, //string
        'videoResume': videoResume,
        'password': password, //string//string
        'occupation': occupation, //string
        'education': education,
        'country': country, //yyyy-mm-dd
        'documentType': documentType,
        'documentLink': documentLink,
        'bankName': bankName, //string
        'ifsc': ifsc, //string
        'userName': userName, //string
        'bankAccountNumber': bankAccountNumber, //string
      };
      print('212121 tutorRegister params $body');
      try {
        var rawResponse = await dio.post(UrlConstants.registerTutor,
            data: body,
            options: Options(contentType: Headers.formUrlEncodedContentType));
        var response = await rawResponse.getResult();
        if (response.isLeft()) {
          result.setLeft(response.getLeft());
        } else {
          var jsonData = json.decode(response.getRight());
          log(jsonData.toString());
          if (jsonData['error']) {
            result.setLeft(CustomError(
                (jsonData['msg'] ?? jsonData['message']).toString()));
          } else {
            var responseModel = (jsonData['token'] ?? '').toString();
            if (responseModel.trim().isEmpty) {
              result.setLeft(UnknownError());
            } else {
              result.setRight(responseModel);
            }
          }
        }
      } on Exception catch (e) {
        if (e is DioError) {
          result.setLeft(e.getDioError());
        } else {
          result.setLeft(CustomError(e.toString()));
        }
      }
    // }
    return result;
  }

  @override
  Future<Either<Failure, bool>> resetPassword(
      String email, String password, int userType) async {
    var result = Either<Failure, bool>();
    var body = {'email': email, 'password': password, 'userType': userType};
    try {
      var rawResponse = await dio.post(UrlConstants.resetPassword,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> sendOtp(String email, int userType) async {
    var result = Either<Failure, String>();
    var body = {'email': email, 'userType': userType};
    try {
      var rawResponse = await dio.post(UrlConstants.sendOTP,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else if (jsonData['otp'] == null) {
          result.setLeft(CustomError('Error fetching OTP'));
        } else {
          result.setRight(jsonData['otp'].toString());
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(
      String email, String otp, int userType) async {
    var result = Either<Failure, bool>();
    var body = {'email': email, 'userType': userType, 'otp': otp};
    try {
      var rawResponse = await dio.post(UrlConstants.verifyOTP,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, String>> fileUpload(File file) async {
    var result = Either<Failure, String>();
    var body = FormData.fromMap({});
    body.files.add(MapEntry('file', await MultipartFile.fromFile(file.path)));

    try {
      var rawResponse = await dio.post(UrlConstants.fileUpload,
          data: body,
          options: Options(
              // contentType: Headers.formUrlEncodedContentType,
              ));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        //log(jsonData.toString());
        if (!jsonData['message'].toString().contains('success')) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          String url = jsonData['data'] ?? '';
          if (url.isEmpty) {
            result.setLeft(CustomError('Error uploading file'));
          } else {
            result.setRight(url);
          }
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
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
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'planDuration': planDuration,
      'amountPaid': amount,
      'classDuration': classDuration,
      'razorpayId': razorpayId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(
          extend
              ? UrlConstants.studentCourseExtend
              : UrlConstants.studentCourseUpdate,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(true);
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      } else {
        result.setLeft(CustomError(e.toString()));
      }
    }
    return result;
  }
}
