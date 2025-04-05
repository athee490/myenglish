import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/attendance_details/data/datasource/attendance_datasource.dart';
import 'package:myenglish/features/attendance_details/data/models/get_student_attendance_model.dart';
import 'package:myenglish/features/attendance_details/data/models/home_attendance_model.dart';
import 'package:myenglish/features/attendance_details/data/models/attendance_details_model.dart';

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final Dio dio;
  AttendanceDataSourceImpl(this.dio);
  @override
  Future<Either<Failure, List<AttendanceDetail>>> getAttendanceHistory(
      String studentId, String fromDate, String toDate) async {
    var result = Either<Failure, List<AttendanceDetail>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'studentId': studentId,
      'fromDate': fromDate,
      'toDate': toDate,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.getAttendanceHistoryDetails,
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
          List<AttendanceDetail> attendanceList = List<AttendanceDetail>.from(
              jsonData["data"].map((x) => AttendanceDetail.fromJson(x)));
          result.setRight(attendanceList);
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
  Future<Either<Failure, List<HomeAttendanceModel>>> getAttendanceLog() async {
    var result = Either<Failure, List<HomeAttendanceModel>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};

    try {
      var rawResponse = await dio.get(UrlConstants.getAttendanceLogDetails,
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
          result.setRight(List<HomeAttendanceModel>.from(
              jsonData['data'].map((x) => HomeAttendanceModel.fromJson(x))));
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
  Future<Either<Failure, GetStudentAttendanceModel>> getAttendanceData() async{
    var result = Either<Failure, GetStudentAttendanceModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};

    try {
      var rawResponse = await dio.get(UrlConstants.getAttendanceLogDetails,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        String modifiedData = response.getRight().toString();
        var jsonData = json.decode(modifiedData);
        log(jsonData.toString());
        if (jsonData['error']) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          var responseModel =GetStudentAttendanceModel.fromJson(json.decode(modifiedData));
          result.setRight(responseModel);
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
