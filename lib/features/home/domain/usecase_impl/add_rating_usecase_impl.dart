import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';

import '../usecase/add_rating_usecase.dart';

class AddRatingUseCaseImpl implements AddRatingUseCase {
  final HomeRepository _repository;
  AddRatingUseCaseImpl(this._repository);
  @override
  Future<Either<Failure, String>> call(
      String callId, String rating, String comment) async {
    return await _repository.addRating(callId, rating, comment);
  }
}
