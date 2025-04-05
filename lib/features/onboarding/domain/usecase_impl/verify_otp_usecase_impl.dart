import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/verify_otp_usecase.dart';

class VerifyOtpUseCaseImpl implements VerifyOtpUseCase {
  final AuthenticationRepository _repository;
  VerifyOtpUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String email, String otp, int userType) async {
    return await _repository.verifyOtp(email, otp, userType);
  }
}
