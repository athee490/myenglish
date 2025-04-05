import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/features/classroom/domain/repository/classroom_repository.dart';
import 'package:myenglish/features/classroom/domain/usecase/send_delay_notification_usecase.dart';

class SendDelayNotificationUseCaseImpl implements SendDelayNotificationUseCase {
  final ClassRoomRepository _repository;
  SendDelayNotificationUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, bool>> call(AppUser userType, String userId) async {
    return await _repository.sendDelayNotification(userType, userId);
  }
}
