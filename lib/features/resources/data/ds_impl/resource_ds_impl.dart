import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myenglish/core/constants/app_urls.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/extension.dart';
import 'package:myenglish/core/utils/services/prefs.dart';
import 'package:myenglish/features/resources/data/datasource/resource_datasource.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/features/resources/data/models/syllabus_model.dart';

class ResourceDataSourceImpl implements ResourceDataSource {
  final Dio dio;

  ResourceDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, ResourceModel>> getResources(
      CourseLevel courseType, Resource resourceType, int pageNo,
      {String? lanuguageFilter}) async {
    var result = Either<Failure, ResourceModel>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      // 'courseLevel': courseType.name,
      'fileType': resourceType.type,
      'page_number': pageNo,
      if (!(lanuguageFilter == null || lanuguageFilter == 'all'))
        'language': lanuguageFilter,
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.courseMaterials,
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
          result.setRight(resourceModelFromJson(response.getRight()));
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
  Future<Either<Failure, List<SyllabusModel>>> getSyllabus(
      CourseLevel courseType) async {
    var result = Either<Failure, List<SyllabusModel>>();
    var header = {'authorization': 'Bearer ${Prefs().getString(Prefs.token)}'};
    var body = {
      'courseLevel': courseType == CourseLevel.student
          ? 'beginner'
          : courseType == CourseLevel.professional
              ? 'intermediate'
              : 'all',
    };
    print(body);
    try {
      var rawResponse = await dio.post(UrlConstants.getSyllabus,
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
          result.setRight(List<SyllabusModel>.from(
              jsonData['data'].map((x) => SyllabusModel.fromJson(x))));
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
