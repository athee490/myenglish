import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/classroom/data/datasource/classroom_datasource.dart';

class ClassRoomDataSourceImpl implements ClassRoomDataSource {
  final Dio dio;
  ClassRoomDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, bool>> sendDelayNotification(
      AppUser userType, String userId) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      if (userType == AppUser.student) 'studentId': userId,
      if (userType == AppUser.tutor) 'tutorId': userId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.sendDelayNotification,
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
  Future<Either<Failure, bool>> logStudentAttendance(String callId) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'call_id': callId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.studentAttendance,
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
  Future<Either<Failure, bool>> logTutorAttendance(String callId) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'call_id': callId,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.tutorAttendance,
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
