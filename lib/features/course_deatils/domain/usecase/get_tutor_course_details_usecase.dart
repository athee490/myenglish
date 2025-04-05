import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/get_tutor_single_course_details_model.dart';

abstract class GetTutorCourseDetailsUseCase {
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>>
      getTutorSingleCourseDetails(String courseId);
}
