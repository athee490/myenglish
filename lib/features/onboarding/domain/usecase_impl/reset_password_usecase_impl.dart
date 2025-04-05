import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/reset_password_usecase.dart';

class ResetPasswordUseCaseImpl implements ResetPasswordUseCase {
  final AuthenticationRepository _repository;
  ResetPasswordUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      String email, String password, int userType) async {
    return await _repository.resetPassword(email, password, userType);
  }
}
