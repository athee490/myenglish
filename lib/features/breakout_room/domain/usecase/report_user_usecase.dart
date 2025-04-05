import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class ReportUserUseCase {
  Future<Either<Failure, bool>> call({
    required String userId,
    required String callId,
    required String reason,
  });
}
