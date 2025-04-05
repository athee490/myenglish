import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/onboarding/domain/repository/authentication_repository.dart';
import 'package:myenglish/features/onboarding/domain/usecase/update_devicetoken_usecase.dart';

class UpdateDeviceTokenUseCaseImpl implements UpdateDeviceTokenUseCase {
  final AuthenticationRepository _repository;
  UpdateDeviceTokenUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(String fcmToken) async {
    return await _repository.updateDeviceToken(fcmToken);
  }
}
