import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import '../../data/models/edit_tutor_course_model.dart';
import '../../data/models/get_tutor_single_course_details_model.dart';
import '../../data/models/student_payment_model.dart';

abstract class TutorCourseRepository {
  Future<Either<Failure, GetTutorSingleCourseDetailsModel>>
      getTutorSingleCourseDetails(String courseId);
  Future<Either<Failure,EditTutorCourseModel>> editTutorCourse(Map<String, dynamic> body,String courseId);
  Future<Either<Failure,StudentPaymentModelClass>> studentPayment(Map<String, dynamic> body,String courseId);

}