import '../../../../core/network/either.dart';
import '../../../../core/network/error.dart';
import '../../data/models/get_student_all_course_model.dart';

abstract class GetStudentAllCourseDetailsUseCase{
  Future<Either<Failure, GetStudentAllCourseModel>> getAllCourseList(String pageNo,String limit,String filter,String search);
}