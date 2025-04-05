import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/home/data/models/get_student_purchased_course_details_model.dart';
import 'package:myenglish/features/home/data/models/get_student_purchased_course_model.dart';
import 'package:myenglish/features/home/data/models/get_tutor_statistics_model.dart';
import 'package:myenglish/features/home/data/models/get_tutor_today_course_model.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';

import '../datasource/home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _dataSource;

  HomeRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String>> addRating(
      String callId, String rating, String comment) async {
    var result = Either<Failure, String>();
    var data = await _dataSource.addRating(callId, rating, comment);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, bool>> checkRating() async {
    var result = Either<Failure, bool>();
    var data = await _dataSource.checkRating();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetPurchasedCourseModel>>
      getStudentPurchasedCourse() async {
    var result = Either<Failure, GetPurchasedCourseModel>();
    var data = await _dataSource.getStudentPurchasedCourse();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetTutorTodayCourseModel>>
      getTutorTodayCourse() async {
    var result = Either<Failure, GetTutorTodayCourseModel>();
    var data = await _dataSource.getTutorTodayCourse();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetTutorStatisticsModel>> getTutorStatistic() async {
    var result = Either<Failure, GetTutorStatisticsModel>();
    var data = await _dataSource.getTutorStatistic();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetStudentPurchasedCourseDetailsModel>>
      getStudentPurchasedCourseDetails(String courseId) async {
    var result = Either<Failure, GetStudentPurchasedCourseDetailsModel>();
    var data = await _dataSource.getStudentPurchasedCourseDetails(courseId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
