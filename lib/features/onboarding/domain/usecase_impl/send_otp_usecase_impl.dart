import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/send_otp_usecase.dart';

class SendOtpUseCaseImpl implements SendOtpUseCase {
  final AuthenticationRepository _repository;
  SendOtpUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, String>> call(String email, int userType) async {
    return await _repository.sendOtp(email, userType);
  }
}
