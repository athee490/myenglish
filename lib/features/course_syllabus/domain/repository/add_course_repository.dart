import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/course_syllabus/data/models/turot_course_reg_model.dart';

import '../../data/models/get_student_all_course_model.dart';
import '../../data/models/student_selected_course_model.dart';
import '../../data/models/tutor_course_details_model.dart';


abstract class TutorCourseRegistrationRepo {
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(String pageNo, String limit, String filter,String search);
  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(String id);
  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(Map<String, dynamic> body);
  Future<Either<Failure, TutorCourseDetailsModel>> getTutorCourseDetails();
}
