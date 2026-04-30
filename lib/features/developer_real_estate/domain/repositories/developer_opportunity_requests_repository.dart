import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_filter_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/res/resource.dart';

abstract class DeveloperOpportunityRequestsRepository {
  Future<Resource<PaginatedResult<DeveloperOpportunityRequestEntity>?>> getOpportunityRequests({
    int page = 1,
    int? cityId,
    String? opportunityType,
    int? communicationRequestTypeId,
    int? developerId,
  });

  Future<Resource<DeveloperOpportunityRequestEntity?>> getOpportunityRequestById(int id);

  Future<Resource<DeveloperOpportunityFiltersCollectionEntity?>> getAvailableFilters();
}
