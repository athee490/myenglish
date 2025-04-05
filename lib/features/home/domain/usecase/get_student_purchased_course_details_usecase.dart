import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/get_student_purchased_course_details_model.dart';

abstract class GetStudentPurchasedCourseDetailsUseCase{
  Future<Either<Failure,GetStudentPurchasedCourseDetailsModel>> getPurchasedCourseDetails(String courseId);
}