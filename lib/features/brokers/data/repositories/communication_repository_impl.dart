import 'package:waseet/features/brokers/data/datasources/communication_data_source.dart';
import 'package:waseet/features/brokers/domain/entities/chat_and_details_entity.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/entities/request/connection_request.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/res/resource.dart';

class CommunicationRepositoryImpl implements CommunicationRepository {
  CommunicationRepositoryImpl({
    required CommunicationDataSource dataSource,
  }) : _dataSource = dataSource;

  final CommunicationDataSource _dataSource;

  @override
  Future<Resource<String>> createRequest(
    ConnectionRequest request,
  ) async {
    try {
      final requestResponse = await _dataSource.createRequest(request);
      if (requestResponse is ResourceError) {
        return Resource.error(
          requestResponse.message!,
          null,
          requestResponse.errors,
        );
      }
      return Resource.success(
        requestResponse.data ?? 'تم بنجاح',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> updateRequest(
    ConnectionRequest request,
    int id,
  ) async {
    try {
      final requestResponse = await _dataSource.updateRequest(request, id);
      if (requestResponse is ResourceError) {
        return Resource.error(
          requestResponse.message!,
          null,
          requestResponse.errors,
        );
      }
      return Resource.success(
        requestResponse.data ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<List<ConnectionRequestEntity>?>> getRequests({
    int? userID,
    String? date,
  }) async {
    try {
      final connectionRequests =
          await _dataSource.getRequests(userID: userID, date: date);
      if (connectionRequests is ResourceError) {
        return Resource.error(
          connectionRequests.message ?? 'حدث خطأ ما ',
          null,
          connectionRequests.errors,
        );
      }
      return Resource.success(connectionRequests.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> deleteRequest(int id) async {
    try {
      final requestResponse = await _dataSource.deleteRequest(id);
      if (requestResponse is ResourceError) {
        return Resource.error(
          requestResponse.message!,
          null,
          requestResponse.errors,
        );
      }
      return Resource.success(
        requestResponse.data ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<List<ConnectionRequestEntity>?>> getFavRequests() async {
    try {
      final connectionRequests = await _dataSource.getFavRequests();
      if (connectionRequests is ResourceError) {
        return Resource.error(
          connectionRequests.message ?? 'حدث خطأ ما ',
          null,
          connectionRequests.errors,
        );
      }
      return Resource.success(connectionRequests.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> addFavRequest(int id) async {
    try {
      final requestResponse = await _dataSource.addFavRequest(id);
      if (requestResponse is ResourceError) {
        return Resource.error(
          requestResponse.message!,
          null,
          requestResponse.errors,
        );
      }
      return Resource.success(
        requestResponse.data ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String>> removeFavRequest(int id) async {
    try {
      final requestResponse = await _dataSource.removeFavRequest(id);
      if (requestResponse is ResourceError) {
        return Resource.error(
          requestResponse.message!,
          null,
          requestResponse.errors,
        );
      }
      return Resource.success(
        requestResponse.data ?? '',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<ChatAndDetailsEntity>> acceptRequest(int id) async {
    final response = await _dataSource.acceptRequest(id);
    if (response is ResourceError) {
      return Resource.error(
        response.message!,
        null,
        response.errors,
      );
    }
    return Resource.success(response.data!);
  }
}
