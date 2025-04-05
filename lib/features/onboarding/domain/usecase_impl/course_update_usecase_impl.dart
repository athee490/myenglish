import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/course_update_usecase.dart';

class CourseUpdateUseCaseImpl implements CourseUpdateUseCase {
  final AuthenticationRepository _repository;
  CourseUpdateUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      {required String planDuration,
      required String amount,
      required String classDuration,
      required String razorpayId,
      required bool extend}) async {
    return await _repository.updatePaymentStatus(
        planDuration: planDuration,
        amount: amount,
        classDuration: classDuration,
        razorpayId: razorpayId,
        extend: extend);
  }
}
