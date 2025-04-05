import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/edit_tutor_course_model.dart';
import '../../data/models/student_payment_model.dart';

abstract class EditTutorCourseUseCase {
  Future<Either<Failure, EditTutorCourseModel>> editTutorCourse(Map<String, dynamic> body, String courseId);
  Future<Either<Failure, StudentPaymentModelClass>> studentPayment(Map<String, dynamic> body, String courseId);
}
