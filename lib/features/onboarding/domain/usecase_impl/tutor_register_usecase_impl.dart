import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/tutor_register_usecase.dart';

class TutorRegisterUseCaseImpl implements TutorRegisterUseCase {
  final AuthenticationRepository _repository;

  TutorRegisterUseCaseImpl(this._repository);

  @override
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
  }) async {
    return await _repository.tutorRegister(
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      phoneCode: phoneCode,
      videoResume: videoResume,
      password: password,
      occupation: occupation,
      education: education,
      country: country,
      documentType: documentType,
      documentLink: documentLink,
      bankName: bankName,
      ifsc: ifsc,
      userName: userName,
      bankAccountNumber: bankAccountNumber,
    );
  }
}
