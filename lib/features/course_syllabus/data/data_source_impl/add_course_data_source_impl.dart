import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import '../../../../core/network/either.dart';
import '../datasource/add_course_data_source.dart';
import '../models/get_student_all_course_model.dart';
import '../models/student_selected_course_model.dart';
import '../models/turot_course_reg_model.dart';
import '../models/tutor_course_details_model.dart';

class TutorCourseRegistrationDataSourceImpl
    implements TutorCourseRegistrationDataSource {
  final Dio dio;

  TutorCourseRegistrationDataSourceImpl(this.dio);

  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(
      Map<String, dynamic> body) async {
    var result = Either<Failure, TutorCourseRegistrationModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.post(UrlConstants.tutorCourseRegistration,
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        var jsonData = json.decode(response.getRight());
        log(jsonData.toString());
        if (jsonData['error'] || jsonData['data'] == null) {
          result.setLeft(
              CustomError((jsonData['msg'] ?? jsonData['message']).toString()));
        } else {
          result.setRight(
              TutorCourseRegistrationModel.fromJson(jsonData['data']));
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

  Future<Either<Failure, TutorCourseDetailsModel>>
      getTutorCourseDetails() async {
    var result = Either<Failure, TutorCourseDetailsModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(UrlConstants.getTutorCourseDetails,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = TutorCourseDetailsModel.fromJson(
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
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(
      String pageNo, String limit, String filter, String search) async {
    var result = Either<Failure, GetStudentAllCourseModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(
          "${UrlConstants.getAllCourseList}?page=$pageNo&limit=$limit&search=$search&filter=$filter",
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetStudentAllCourseModel.fromJson(
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
  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(String id) async {
    var result = Either<Failure, StudentSelectedCourseModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(
          "${UrlConstants.getAllCourseList}/$id",
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = StudentSelectedCourseModel.fromJson(
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
