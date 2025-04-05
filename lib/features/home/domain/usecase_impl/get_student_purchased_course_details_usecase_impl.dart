import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import '../../data/models/get_student_purchased_course_details_model.dart';
import '../repository/home_repository.dart';
import '../usecase/get_student_purchased_course_details_usecase.dart';

class GetStudentPurchasedCourseDetailsUseCaseImpl
    extends GetStudentPurchasedCourseDetailsUseCase {
  final HomeRepository _homeRepository;

  GetStudentPurchasedCourseDetailsUseCaseImpl(this._homeRepository);

  @override
  Future<Either<Failure, GetStudentPurchasedCourseDetailsModel>>
      getPurchasedCourseDetails(String courseId) async {
    return await _homeRepository.getStudentPurchasedCourseDetails(courseId);
  }
}
