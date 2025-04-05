import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class ChangePasswordUseCase {
  Future<Either<Failure, bool>> call({
    required String oldPassword,
    required String newPassword,
  });
}
