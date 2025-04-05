import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/student_login_usecase.dart';

class StudentLoginUseCaseImpl implements StudentLoginUseCase {
  final AuthenticationRepository _repository;
  StudentLoginUseCaseImpl(this._repository);
  @override
  Future<Either<Failure, String>> call(String email, String password) async {
    return await _repository.studentLogin(email, password);
  }
}
