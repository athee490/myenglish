import 'package:myenglish/core/network/error.dart';

import '../../../../core/network/either.dart';
import '../../data/models/get_student_purchased_course_model.dart';

abstract class GetStudentPurchasedCourseUseCase{
  Future<Either<Failure,GetPurchasedCourseModel>> getPurchasedCourse();
}