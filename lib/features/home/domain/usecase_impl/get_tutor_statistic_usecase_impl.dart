import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/features/home/data/models/get_tutor_statistics_model.dart';
import 'package:myenglish/features/home/domain/repository/home_repository.dart';

import '../usecase/get_tutor_statistic_usecase.dart';

class GetTutorStatisticUseCaseImpl extends GetTutorStatisticUseCase {
  HomeRepository _homeRepository;

  GetTutorStatisticUseCaseImpl(this._homeRepository);

  @override
  Future<Either<Failure, GetTutorStatisticsModel>> getTutorStatistic() async {
    return await _homeRepository.getTutorStatistic();
  }
}
