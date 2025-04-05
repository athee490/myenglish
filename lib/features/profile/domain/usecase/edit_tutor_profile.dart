import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class EditTutorProfileUseCase {
  Future<Either<Failure, bool>> call({
    required String name,
    required String occupation,
    required String country,
    required String bankName,
    required String ifsc,
    required String bankAccountNumber,
    required String userName,
  });
}
