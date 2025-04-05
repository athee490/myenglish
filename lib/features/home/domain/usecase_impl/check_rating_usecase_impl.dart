import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';

import '../usecase/check_rating_usecase.dart';

class CheckRatingUseCaseImpl implements CheckRatingUseCase {
  final HomeRepository _repository;
  CheckRatingUseCaseImpl(this._repository);
  @override
  Future<Either<Failure, bool>> call() async {
    return await _repository.checkRating();
  }
}
