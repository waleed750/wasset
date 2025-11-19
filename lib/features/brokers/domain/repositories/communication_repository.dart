import 'package:waseet/features/brokers/domain/entities/chat_and_details_entity.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/entities/request/connection_request.dart';
import 'package:waseet/res/resource.dart';

abstract class CommunicationRepository {
  Future<Resource<String>> createRequest(
    ConnectionRequest request,
  );
  Future<Resource<String>> updateRequest(ConnectionRequest request, int id);
  Future<Resource<String>> deleteRequest(int id);
  Future<Resource<String>> addFavRequest(int id);
  Future<Resource<String>> removeFavRequest(int id);
  Future<Resource<List<ConnectionRequestEntity>?>> getRequests({
    int? userID,
    String? date,
  });
  Future<Resource<List<ConnectionRequestEntity>?>> getFavRequests();

  Future<Resource<ChatAndDetailsEntity>> acceptRequest(int id);
}
