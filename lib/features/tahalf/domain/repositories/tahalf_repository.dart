import 'package:waseet/features/tahalf/domain/entities/request/attach_to_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/request/create_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/res/resource.dart';

abstract class TahalfRepository {
  Future<Resource<String>> createTahalf(CreateTahalfRequest request);
  Future<Resource<String>> updateTahalf(CreateTahalfRequest request, int id);
  Future<Resource<List<TahalfEntity>>> getTahalfat();
  Future<Resource<String>> attachToTahalf(
    AttachToTahalfRequest request,
  );
  Future<Resource<String>> exitFromTahalf(AttachToTahalfRequest request);
  Future<Resource<String>> deleteTahalf(int tahalfId);
}
