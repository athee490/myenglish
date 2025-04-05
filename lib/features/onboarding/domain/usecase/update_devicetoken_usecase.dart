import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class UpdateDeviceTokenUseCase {
  Future<Either<Failure, bool>> call(String fcmToken);
}
