import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/course_deatils/data/models/edit_tutor_course_model.dart';
import 'package:myenglish/features/course_deatils/data/models/student_payment_model.dart';
import '../repository/tutor_course_repository.dart';
import '../usecase/edit_tutor_course_usecase.dart';

class EditTutorCourseUseCaseImpl extends EditTutorCourseUseCase {
  final TutorCourseRepository _tutorCourseRepository;

  EditTutorCourseUseCaseImpl(this._tutorCourseRepository);

  @override
  Future<Either<Failure, EditTutorCourseModel>> editTutorCourse(Map<String, dynamic> body, String courseId) async {
    return await _tutorCourseRepository.editTutorCourse(body,courseId);
  }

  @override
  Future<Either<Failure, StudentPaymentModelClass>> studentPayment(Map<String, dynamic> body,String courseId) async{
   return await _tutorCourseRepository.studentPayment(body, courseId);
  }
}
