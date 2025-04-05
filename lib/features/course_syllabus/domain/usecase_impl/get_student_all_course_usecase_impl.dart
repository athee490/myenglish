import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/course_syllabus/data/models/get_student_all_course_model.dart';
import '../repository/add_course_repository.dart';
import '../usecase/get_student_all_course_usecase.dart';

class GetStudentAllCourseUseCaseImpl extends GetStudentAllCourseDetailsUseCase {
  final TutorCourseRegistrationRepo _tutorCourseRegistrationRepo;

  GetStudentAllCourseUseCaseImpl(this._tutorCourseRegistrationRepo);

  @override
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(String pageNo, String limit, String filter,String search) async{
    return await _tutorCourseRegistrationRepo.getAllCourseList(pageNo,limit,filter,search);
  }
}
