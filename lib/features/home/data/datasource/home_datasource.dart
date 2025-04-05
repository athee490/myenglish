import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import '../../../home/data/models/get_student_purchased_course_details_model.dart';
import '../../../home/data/models/get_student_purchased_course_model.dart';
import '../../../home/data/models/get_tutor_statistics_model.dart';
import '../../../home/data/models/get_tutor_today_course_model.dart';
abstract class HomeDataSource {
  Future<Either<Failure,GetPurchasedCourseModel>> getStudentPurchasedCourse();
  Future<Either<Failure,GetTutorTodayCourseModel>> getTutorTodayCourse();
  Future<Either<Failure,GetStudentPurchasedCourseDetailsModel>> getStudentPurchasedCourseDetails(String courseId);
  Future<Either<Failure,GetTutorStatisticsModel>> getTutorStatistic();
  Future<Either<Failure, bool>> logStudentAttendance(String callId);
  Future<Either<Failure, bool>> logTutorAttendance(String callId);
  Future<Either<Failure, String>> addRating(
      String callId, String rating, String comment);
  Future<Either<Failure, bool>> checkRating();
}
