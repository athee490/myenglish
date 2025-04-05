import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/course_syllabus/data/models/turot_course_reg_model.dart';
import 'package:myenglish/features/course_syllabus/data/models/tutor_course_details_model.dart';

import '../repository/add_course_repository.dart';
import '../usecase/add_course_usecase.dart';

class TutorCourseRegistrationUseCaseImpl implements TutorCourseRegistrationUseCase{
  final TutorCourseRegistrationRepo _tutorCourseRegistrationRepo;
  TutorCourseRegistrationUseCaseImpl(this._tutorCourseRegistrationRepo);

  @override
  Future<Either<Failure, TutorCourseRegistrationModel>> tutorCourseReg(Map<String, dynamic> body) async{
    return await _tutorCourseRegistrationRepo.tutorCourseReg(body);
  }

}