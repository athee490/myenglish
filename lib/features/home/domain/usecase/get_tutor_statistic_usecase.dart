import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/network/error.dart';
import '../../data/models/get_tutor_statistics_model.dart';

abstract class GetTutorStatisticUseCase{
  Future<Either<Failure,GetTutorStatisticsModel>> getTutorStatistic();
}