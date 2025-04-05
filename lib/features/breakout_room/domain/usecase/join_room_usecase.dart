import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class JoinBreakoutRoomUseCase {
  Future<Either<Failure, bool>> call(String callId, String log);
}
