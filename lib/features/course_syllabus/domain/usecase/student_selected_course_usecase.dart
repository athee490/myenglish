import 'package:myenglish/core/network/error.dart';

import '../../../../core/network/either.dart';
import '../../data/models/student_selected_course_model.dart';

abstract class StudentSelectedCourseUseCase{
  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(String id);
}