import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/features/resources/domain/repository/resource_repository.dart';
import 'package:myenglish/features/resources/domain/usecase/document_resource_usecase.dart';

class DocumentResourceUseCaseImpl implements DocumentResourceUseCase {
  final ResourceRepository _repository;
  DocumentResourceUseCaseImpl(this._repository);

  @override
  Future<Either<Failure, ResourceModel>> call(
      CourseLevel courseType, int pageNo) async {
    return await _repository.getResources(
        courseType, Resource.document, pageNo);
  }
}
