import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class TutorRegisterUseCase {
  Future<Either<Failure, String>> call({
    required String name,
    required String email,
    required String phoneNumber,
    required String phoneCode,
    required String videoResume,
    required String password,
    required String occupation,
    required String education,
    required String country,
    required String documentType,
    required String documentLink,
    required String bankName,
    required String ifsc,
    required String userName,
    required String bankAccountNumber,
  });
}
