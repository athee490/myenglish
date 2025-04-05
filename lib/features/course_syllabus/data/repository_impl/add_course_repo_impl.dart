import 'package:myenglish/features/course_syllabus/data/models/student_selected_course_model.dart';
import 'package:myenglish/features/course_syllabus/data/models/tutor_course_details_model.dart';

import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../domain/repository/add_course_repository.dart';
import '../datasource/add_course_data_source.dart';
import '../models/get_student_all_course_model.dart';
import '../models/turot_course_reg_model.dart';

class TutorCourseRegistrationRepoImpl implements TutorCourseRegistrationRepo {
  final TutorCourseRegistrationDataSource _tutorCourseRegistrationDataSource;

  TutorCourseRegistrationRepoImpl(this._tutorCourseRegistrationDataSource);

  @override
  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(
      Map<String, dynamic> body) async {
    var result = Either<Failure, TutorCourseRegistrationModel>();
    var data = await _tutorCourseRegistrationDataSource.tutorCourseReg(body);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, TutorCourseDetailsModel>>
      getTutorCourseDetails() async {
    var result = Either<Failure, TutorCourseDetailsModel>();
    var data = await _tutorCourseRegistrationDataSource.getTutorCourseDetails();
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(
      String pageNo, String limit, String filter, String search) async {
    var result = Either<Failure, GetStudentAllCourseModel>();
    var data = await _tutorCourseRegistrationDataSource.getAllCourseList(
        pageNo, limit, filter, search);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(String id) async{
    var result = Either<Failure,StudentSelectedCourseModel>();
    var data = await _tutorCourseRegistrationDataSource.getSingleCourseDetails(id);
    if(data.isLeft()){
      result.setLeft(data.getLeft());
    }else{
      result.setRight(data.getRight());
    }
    return result;
  }


}
