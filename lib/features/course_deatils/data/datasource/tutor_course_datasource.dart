import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../models/edit_tutor_course_model.dart';
import '../models/get_tutor_single_course_details_model.dart';
import '../models/student_payment_model.dart';

abstract class TutorDataSource {
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>>
      getTutorSingleCourseDetails(String courseId);

  Future<Either<Failure, EditTutorCourseModel>> editTutorCourse(
      Map<String, dynamic> body, String courseId);

  Future<Either<Failure, StudentPaymentModelClass>> studentPayment(Map<String, dynamic> body,String courseId );
}
