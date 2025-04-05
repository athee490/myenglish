import 'package:myenglish/core/network/error.dart';
import 'package:myenglish/core/network/either.dart';
import 'package:myenglish/core/constants/enums.dart';
import 'package:myenglish/features/resources/data/datasource/resource_datasource.dart';
import 'package:myenglish/features/resources/data/models/resource_model.dart';
import 'package:myenglish/features/resources/data/models/syllabus_model.dart';
import 'package:myenglish/features/resources/domain/repository/resource_repository.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceDataSource _dataSource;
  ResourceRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ResourceModel>> getResources(
      CourseLevel courseType, Resource resourceType, int pageNo,
      {String? lanuguageFilter}) async {
    var result = Either<Failure, ResourceModel>();
    var data = await _dataSource.getResources(courseType, resourceType, pageNo,
        lanuguageFilter: lanuguageFilter);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }

  @override
  Future<Either<Failure, List<SyllabusModel>>> getSyllabus(
      CourseLevel courseType) async {
    var result = Either<Failure, List<SyllabusModel>>();
    var data = await _dataSource.getSyllabus(courseType);
    if (data.isLeft()) {
      result.setLeft(data.getLeft());
    } else {
      result.setRight(data.getRight());
    }
    return result;
  }
}
