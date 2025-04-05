import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';

abstract class CheckRatingUseCase {
  Future<Either<Failure, bool>> call();
}
