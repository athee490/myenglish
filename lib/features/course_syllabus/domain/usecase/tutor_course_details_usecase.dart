import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/tutor_course_details_model.dart';

abstract class TutorCourseDetailsUseCase {
  Future<Either<Failure, TutorCourseDetailsModel>> getTutorCourseDetails();
}