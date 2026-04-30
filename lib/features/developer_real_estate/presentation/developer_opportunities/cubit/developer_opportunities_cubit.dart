import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_filter_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_opportunity_requests_repository.dart';
import 'package:waseet/res/resource.dart';

part 'developer_opportunities_state.dart';

class DeveloperOpportunitiesCubit extends Cubit<DeveloperOpportunitiesState> {

  DeveloperOpportunitiesCubit({
    required DeveloperOpportunityRequestsRepository repository,
  })  : _repository = repository,
        super(const DeveloperOpportunitiesInitial());
  final DeveloperOpportunityRequestsRepository _repository;

  // Current filter state
  int? _selectedCityId;
  String? _selectedOpportunityType;
  int? _selectedCommunicationRequestTypeId;
  int? _selectedDeveloperId;
  DeveloperOpportunityFilterEntity? _selectedOpportunityTypeEntity;
  DeveloperOpportunityFilterEntity? _selectedCommunicationRequestTypeEntity;
  DeveloperOpportunityFilterEntity? _selectedDeveloperEntity;
  DeveloperOpportunityFiltersCollectionEntity? _availableFilters;

  int _currentPage = 1;

  // Initialize - fetch filters and load first page
  Future<void> init() async {
    emit(const DeveloperOpportunitiesLoading());

    // Get available filters
    final filterResult = await _repository.getAvailableFilters();

    if (filterResult is ResourceSuccess) {
      _availableFilters = filterResult.data;
    }

    // Load first page
    await _loadRequests();
  }

  // Refresh current list
  Future<void> refreshRequests() async {
    _currentPage = 1;
    await _loadRequests();
  }

  // Load more (pagination)
  Future<void> loadMore() async {
    if (state is! DeveloperOpportunitiesLoaded) return;

    final currentState = state as DeveloperOpportunitiesLoaded;
    if (currentState.currentPage >= currentState.lastPage) return;

    _currentPage = currentState.currentPage + 1;
    await _loadRequests(appendToExisting: true);
  }

  // Apply filters
  Future<void> applyFilters({
    int? cityId,
    DeveloperOpportunityFilterEntity? opportunityType,
    DeveloperOpportunityFilterEntity? communicationRequestType,
    DeveloperOpportunityFilterEntity? developer,
  }) async {
    _selectedCityId = cityId;
    _selectedOpportunityType = opportunityType?.name;
    _selectedCommunicationRequestTypeId = communicationRequestType?.id;
    _selectedDeveloperId = developer?.id;
    _selectedOpportunityTypeEntity = opportunityType;
    _selectedCommunicationRequestTypeEntity = communicationRequestType;
    _selectedDeveloperEntity = developer;

    _currentPage = 1;
    await _loadRequests();
  }

  // Clear filters
  Future<void> clearFilters() async {
    _selectedCityId = null;
    _selectedOpportunityType = null;
    _selectedCommunicationRequestTypeId = null;
    _selectedDeveloperId = null;
    _selectedOpportunityTypeEntity = null;
    _selectedCommunicationRequestTypeEntity = null;
    _selectedDeveloperEntity = null;

    _currentPage = 1;
    await _loadRequests();
  }

  // Load detail for a specific request
  Future<void> loadDetail(int requestId) async {
    emit(const DeveloperOpportunitiesDetailLoading());

    final result = await _repository.getOpportunityRequestById(requestId);

    if (result is ResourceSuccess) {
      final entity = result.data;
      if (entity != null) {
        emit(DeveloperOpportunitiesDetailLoaded(request: entity));
      } else {
        emit(
          const DeveloperOpportunitiesDetailError(
            message: 'Failed to load request details',
          ),
        );
      }
    } else if (result is ResourceError) {
      emit(
        DeveloperOpportunitiesDetailError(
          message: result.message ?? 'Failed to load request details',
        ),
      );
    }
  }

  // Private helper to load requests
  Future<void> _loadRequests({bool appendToExisting = false}) async {
    emit(const DeveloperOpportunitiesLoading());

    final result = await _repository.getOpportunityRequests(
      page: _currentPage,
      cityId: _selectedCityId,
      opportunityType: _selectedOpportunityType,
      communicationRequestTypeId: _selectedCommunicationRequestTypeId,
      developerId: _selectedDeveloperId,
    );

    if (result is ResourceSuccess) {
      final paginatedResult = result.data;
      if (paginatedResult != null) {
        final existingRequests = (appendToExisting && state is DeveloperOpportunitiesLoaded)
            ? (state as DeveloperOpportunitiesLoaded).requests
            : <DeveloperOpportunityRequestEntity>[];

        final allRequests = [...existingRequests, ...paginatedResult.data];

        emit(
          DeveloperOpportunitiesLoaded(
            requests: allRequests,
            currentPage: paginatedResult.currentPage,
            lastPage: paginatedResult.lastPage,
            totalCount: paginatedResult.total,
            availableFilters: _availableFilters,
            selectedOpportunityType: _selectedOpportunityTypeEntity,
            selectedCommunicationRequestType:
                _selectedCommunicationRequestTypeEntity,
            selectedDeveloper: _selectedDeveloperEntity,
            selectedCityId: _selectedCityId,
          ),
        );
      } else {
        emit(
          const DeveloperOpportunitiesError(
            message: 'Failed to load requests',
          ),
        );
      }
    } else if (result is ResourceError) {
      emit(
        DeveloperOpportunitiesError(
          message: result.message ?? 'Failed to load requests',
        ),
      );
    }
  }
}
