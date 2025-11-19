import 'package:waseet/features/tahalf/data/datasources/tahalf_data_source.dart';
import 'package:waseet/features/tahalf/domain/entities/request/attach_to_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/request/create_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/res/resource.dart';

class TahalfRepositoryImpl implements TahalfRepository {
  TahalfRepositoryImpl({
    required TahalfDataSource dataSource,
  }) : _dataSource = dataSource;

  final TahalfDataSource _dataSource;

  @override
  Future<Resource<String>> createTahalf(
    CreateTahalfRequest request,
  ) async {
    try {
      final tahalf = await _dataSource.createTahalf(request);
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(
        tahalf.data!,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<List<TahalfEntity>>> getTahalfat() async {
    try {
      final tahalf = await _dataSource.getTahalfat();
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(
        tahalf.data!,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> attachToTahalf(
    AttachToTahalfRequest request,
  ) async {
    try {
      final tahalf = await _dataSource.attachToTahalf(request);
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(tahalf.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> deleteTahalf(int tahalfId) async {
    try {
      final tahalf = await _dataSource.deleteTahalf(tahalfId);
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(tahalf.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> exitFromTahalf(AttachToTahalfRequest request) async {
    try {
      final tahalf = await _dataSource.exitFromTahalf(request);
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(tahalf.data!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> updateTahalf(
    CreateTahalfRequest request,
    int id,
  ) async {
    try {
      final tahalf = await _dataSource.updateTahalf(request, id);
      if (tahalf is ResourceError) {
        return Resource.error(tahalf.message!, null, tahalf.errors);
      }
      return Resource.success(
        tahalf.data!,
      );
    } catch (e) {
      rethrow;
    }
  }
}
