import 'package:waseet/features/developer_real_estate/data/datasources/developer_opportunity_requests_datasource.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_filter_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_opportunity_requests_repository.dart';
import 'package:waseet/res/resource.dart';

class DeveloperOpportunityRequestsRepositoryImpl
    implements DeveloperOpportunityRequestsRepository {

  DeveloperOpportunityRequestsRepositoryImpl({
    required DeveloperOpportunityRequestsDatasource datasource,
  }) : _datasource = datasource;
  final DeveloperOpportunityRequestsDatasource _datasource;

  @override
  Future<Resource<PaginatedResult<DeveloperOpportunityRequestEntity>?>>
      getOpportunityRequests({
    int page = 1,
    int? cityId,
    String? opportunityType,
    int? communicationRequestTypeId,
    int? developerId,
  }) async {
    return _datasource.getOpportunityRequests(
      page: page,
      cityId: cityId,
      opportunityType: opportunityType,
      communicationRequestTypeId: communicationRequestTypeId,
      developerId: developerId,
    );
  }

  @override
  Future<Resource<DeveloperOpportunityRequestEntity?>>
      getOpportunityRequestById(int id) async {
    return _datasource.getOpportunityRequestById(id);
  }

  @override
  Future<Resource<DeveloperOpportunityFiltersCollectionEntity?>>
      getAvailableFilters() async {
    return _datasource.getAvailableFilters();
  }
}
