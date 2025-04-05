import 'package:myenglish/core/network/either.dart';

import '../../../../core/network/error.dart';
import '../../data/models/broom_enabled_model.dart';

abstract class BRoomEnabledListUseCase {
  Future<Either<Failure, List<BRoomEnabledModel>>> call();
}
