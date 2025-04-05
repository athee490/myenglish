import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/course_deatils/data/datasource/tutor_course_datasource.dart';
import 'package:myenglish/features/home/data/datasource/home_datasource.dart';
import 'package:myenglish/features/home/data/models/get_student_purchased_course_details_model.dart';
import 'package:myenglish/features/home/data/models/get_student_purchased_course_model.dart';
import 'package:myenglish/features/home/data/models/get_tutor_statistics_model.dart';
import 'package:myenglish/features/home/data/models/get_tutor_today_course_model.dart';

class HomeDataSourceImpl implements  HomeDataSource {
  final Dio dio;

  HomeDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, bool>> logStudentAttendance(String callId) async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'call_id': callId,
    };
    try {
      var rawResponse = await dio.post(UrlConstants.studentAttendance,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      print('212121 logStudentAttendance $rawResponse');
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
    try {
      var rawResponse = await dio.post(UrlConstants.tutorAttendance,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      print('212121 logTutorAttendance $rawResponse');
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
  Future<Either<Failure, String>> addRating(
      String callId, String rating, String comment) async {
    var result = Either<Failure, String>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'call_id': callId,
      'rating': rating,
      'comment': comment,
    };
    try {
      var rawResponse = await dio.post(UrlConstants.addRating,
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
          result.setRight(jsonData['message']);
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
  Future<Either<Failure, bool>> checkRating() async {
    var result = Either<Failure, bool>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.checkRating,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      print('212121 checkRating response $rawResponse');
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
          if (jsonData['result'].isNotEmpty) {
            if (jsonData['result'][0]['rating'] != null) {
              result.setRight(true);
            } else {
              result.setRight(false);
            }
          } else {
            result.setRight(true);
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
  Future<Either<Failure, GetPurchasedCourseModel>>
      getStudentPurchasedCourse() async {
    var result = Either<Failure, GetPurchasedCourseModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getStudentPurchasedCourse,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetPurchasedCourseModel.fromJson(
              json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, GetTutorTodayCourseModel>>
      getTutorTodayCourse() async {
    var result = Either<Failure, GetTutorTodayCourseModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getTutorTodayCourseDetails,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetTutorTodayCourseModel.fromJson(
              json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, GetTutorStatisticsModel>> getTutorStatistic() async {
    var result = Either<Failure, GetTutorStatisticsModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getTutorStatistic,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetTutorStatisticsModel.fromJson(
              json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      }
    }
    return result;
  }

  @override
  Future<Either<Failure, GetStudentPurchasedCourseDetailsModel>> getStudentPurchasedCourseDetails(String courseId) async{
    var result = Either<Failure, GetStudentPurchasedCourseDetailsModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get("${UrlConstants.getStudentPurchasedCourse}/$courseId",
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetStudentPurchasedCourseDetailsModel.fromJson(
              json.decode(response.getRight()));
          result.setRight(responseModel);
        } else {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        }
      }
    } on Exception catch (e) {
      if (e is DioError) {
        result.setLeft(e.getDioError());
      }
    }
    return result;
  }
}
