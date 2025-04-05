import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/course_deatils/data/models/get_tutor_single_course_details_model.dart';
import '../../../home/data/models/get_student_purchased_course_details_model.dart';
import '../repository/tutor_course_repository.dart';
import '../usecase/get_tutor_course_details_usecase.dart';

class GetTutorCourseDetailsUseCaseImpl
    extends GetTutorCourseDetailsUseCase {
  final TutorCourseRepository _tutorCourseRepository;

  GetTutorCourseDetailsUseCaseImpl(this._tutorCourseRepository);

  @override
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>> getTutorSingleCourseDetails(String courseId) async{
    return await _tutorCourseRepository.getTutorSingleCourseDetails(courseId);
  }

}
