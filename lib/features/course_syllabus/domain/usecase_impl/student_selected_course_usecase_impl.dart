import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/course_syllabus/data/models/student_selected_course_model.dart';

import '../repository/add_course_repository.dart';
import '../usecase/student_selected_course_usecase.dart';

class StudentSelectedCourseUseCaseImpl extends StudentSelectedCourseUseCase {
  final TutorCourseRegistrationRepo _tutorCourseRegistrationRepo;

  StudentSelectedCourseUseCaseImpl(this._tutorCourseRegistrationRepo);

  @override
  Future<Either<Failure, StudentSelectedCourseModel>> getSingleCourseDetails(
      String id) {
    return _tutorCourseRegistrationRepo.getSingleCourseDetails(id);
  }
}
