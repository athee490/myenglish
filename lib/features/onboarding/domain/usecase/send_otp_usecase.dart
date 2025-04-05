import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class SendOtpUseCase {
  Future<Either<Failure, String>> call(String email, int userType);
}
