import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_constants.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/helpers/app_helpers.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/di/di.dart';
import 'package:myenglish/features/profile/data/datasource/profile_datasource.dart';
import 'package:myenglish/features/profile/data/models/student_profile_model.dart';
import 'package:myenglish/features/profile/data/models/tutor_profile_model.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, StudentProfileModel>> getStudentProfile() async {
    var result = Either<Failure, StudentProfileModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getStudentProfile,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      print('2121212 getStudentProfile response $response');
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (!jsonData['error']) {
          var responseModel =
              StudentProfileModel.fromJson(json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
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
  Future<Either<Failure, TutorProfileModel>> getTutorProfile() async {
    var result = Either<Failure, TutorProfileModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getTutorProfile,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      print('2121212 getTutorProfile response $response');
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (!jsonData['error']) {
          var responseModel =
              TutorProfileModel.fromJson(json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
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
  Future<Either<Failure, bool>> editStudentProfile({
    required String name,
    required String enrollment,
    required String country,
    required String phoneCode,
  }) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'name': name,
      'enrollment': enrollment,
      'country': country,
      'phoneCode': phoneCode,
    };
    print('EditedStudentProfileData:$body');
    try {
      var rawResponse = await dio.post(UrlConstants.editStudentProfile,
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

  @override
  Future<Either<Failure, bool>> editTutorProfile({
    required String name,
    required String occupation,
    required String country,
    required String bankName,
    required String ifsc,
    required String bankAccountNumber,
    required String userName,
  }) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'name': name,
      'occupation': occupation,
      'country': country,
      'bankName': bankName,
      'ifsc': ifsc,
      'bankAccountNumber': bankAccountNumber,
      'userName': userName,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.edittutorProfile,
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

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'userType': appUserMap[getAppUser],
      'oldPassword': oldPassword,
      'confirmPassword': newPassword,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.comparePassword,
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
