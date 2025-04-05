import 'package:myenglish/core/network/either.dart';

import 'package:myenglish/core/network/error.dart';

import 'package:myenglish/features/home/data/models/get_student_purchased_course_model.dart';

import '../repository/home_repository.dart';
import '../usecase/get_student_purchased_useCase.dart';

class GetStudentPurchasedCourseUseCaseImpl
    extends GetStudentPurchasedCourseUseCase {
  final HomeRepository _homeRepository;

  GetStudentPurchasedCourseUseCaseImpl(this._homeRepository);

  @override
  Future<Either<Failure, GetPurchasedCourseModel>> getPurchasedCourse() async {
    return await _homeRepository.getStudentPurchasedCourse();
  }
}
