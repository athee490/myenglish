import 'package:myenglish/core/network/error.dart';

import '../../../../core/network/either.dart';
import '../../data/models/get_tutor_today_course_model.dart';

abstract class GetTutorTodayCourseUseCase {
  Future<Either<Failure,GetTutorTodayCourseModel>> getTutorTodayCourse();
}