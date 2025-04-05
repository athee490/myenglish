import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class VerifyOtpUseCase {
  Future<Either<Failure, bool>> call(String email, String otp, int userType);
}
