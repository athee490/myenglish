import 'package:myenglish/core/network/error.dart';

import '../../../../core/network/either.dart';
import '../../data/models/turot_course_reg_model.dart';
import '../../data/models/tutor_course_details_model.dart';

abstract class TutorCourseRegistrationUseCase {
  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(Map<String, dynamic> body);
}
