import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class StudentLoginUseCase {
  Future<Either<Failure, String>> call(String email, String password);
}
