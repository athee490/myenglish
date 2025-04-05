import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class SendDelayNotificationUseCase {
  Future<Either<Failure, bool>> call(AppUser userType, String userId);
}
