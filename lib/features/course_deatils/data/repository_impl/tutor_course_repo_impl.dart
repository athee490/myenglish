import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/course_deatils/data/models/edit_tutor_course_model.dart';
import 'package:myenglish/features/course_deatils/data/models/get_tutor_single_course_details_model.dart';
import '../../domain/repository/tutor_course_repository.dart';
import '../datasource/tutor_course_datasource.dart';
import '../models/student_payment_model.dart';

class TutorCourseRepositoryImpl implements TutorCourseRepository {
  final TutorDataSource _dataSource;

  TutorCourseRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>>
      getTutorSingleCourseDetails(String courseId) async {
    var result = Either<Failure, GetTutorSingleCourseDetailsModel>();
    var data = await _dataSource.getTutorSingleCourseDetails(courseId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, EditTutorCourseModel>> editTutorCourse(
      Map<String, dynamic> body, String courseId) async {
    var result = Either<Failure, EditTutorCourseModel>();
    var data = await _dataSource.editTutorCourse(body, courseId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, StudentPaymentModelClass>> studentPayment(Map<String, dynamic> body,String courseId) async{
    var result = Either<Failure, StudentPaymentModelClass>();
    var data = await _dataSource.studentPayment(body, courseId);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }


}
