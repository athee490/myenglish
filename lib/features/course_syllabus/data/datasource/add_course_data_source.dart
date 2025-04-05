import 'package:myenglish/core/network/error.dart';

import '../../../../core/network/either.dart';
import '../models/get_student_all_course_model.dart';
import '../models/student_selected_course_model.dart';
import '../models/turot_course_reg_model.dart';
import '../models/tutor_course_details_model.dart';

abstract class TutorCourseRegistrationDataSource {
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(
      String pageNo, String limit, String filter, String search);

  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(
      String id);

  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(
      Map<String, dynamic> body);

  Future<Either<Failure, TutorCourseDetailsModel>> getTutorCourseDetails();
}
