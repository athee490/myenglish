import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/course_deatils/data/models/edit_tutor_course_model.dart';
import 'package:myenglish/features/course_deatils/data/models/get_tutor_single_course_details_model.dart';
import 'package:myenglish/features/course_deatils/data/models/student_payment_model.dart';
import '../datasource/tutor_course_datasource.dart';

class TutorCourseDataSourceImpl implements TutorDataSource {
  final Dio dio;

  TutorCourseDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>>
      getTutorSingleCourseDetails(String courseId) async {
    var result = Either<Failure, GetTutorSingleCourseDetailsModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.get(
          "${UrlConstants.getTutorCourseDetails}/$courseId",
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = GetTutorSingleCourseDetailsModel.fromJson(
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
  Future<Either<Failure, EditTutorCourseModel>> editTutorCourse(
      Map<String, dynamic> body, String courseId) async {
    var result = Either<Failure, EditTutorCourseModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.put(
          "${UrlConstants.editTutorCourse}/$courseId",
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel =
              EditTutorCourseModel.fromJson(json.decode(response.getRight()));
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
  Future<Either<Failure, StudentPaymentModelClass>> studentPayment(
      Map<String, dynamic> body, String courseId) async {
    var result = Either<Failure, StudentPaymentModelClass>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    try {
      var rawResponse = await dio.post('${UrlConstants.payment}$courseId',
          data: body,
          options: Options(
              contentType: Headers.formUrlEncodedContentType, headers: header));
      var response = await rawResponse.getResult();
      if (response.isLeft()) {
        result.setLeft(response.getLeft());
      } else {
        log(response.getRight());
        var jsonData = json.decode(response.getRight());
        if (!jsonData['error']) {
          var responseModel = StudentPaymentModelClass.fromJson(
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
