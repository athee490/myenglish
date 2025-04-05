import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/course_syllabus/data/models/tutor_course_details_model.dart';

import '../repository/add_course_repository.dart';
import '../usecase/tutor_course_details_usecase.dart';

class TutorCourseDetailsUseCaseImpl implements TutorCourseDetailsUseCase{
  final TutorCourseRegistrationRepo _tutorCourseRegistrationRepo;
  TutorCourseDetailsUseCaseImpl(this._tutorCourseRegistrationRepo);
  @override
  Future<Either<Failure, TutorCourseDetailsModel>> getTutorCourseDetails() async{
    return await _tutorCourseRegistrationRepo.getTutorCourseDetails();
  }
}