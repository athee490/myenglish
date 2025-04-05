import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_login_usecase.dart';

class TutorLoginUseCaseImpl implements TutorLoginUseCase {
  final AuthenticationRepository _repository;
  TutorLoginUseCaseImpl(this._repository);
  @override
  Future<Either<Failure, String>> call(String email, String password) async {
    return await _repository.tutorLogin(email, password);
  }
}
