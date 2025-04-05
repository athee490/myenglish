import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class ResetPasswordUseCase {
  Future<Either<Failure, bool>> call(
      String email, String password, int userType);
}
