import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class TutorLoginUseCase {
  Future<Either<Failure, String>> call(String email, String password);
}
