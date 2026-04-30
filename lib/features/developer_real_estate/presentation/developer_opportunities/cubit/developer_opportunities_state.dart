part of 'developer_opportunities_cubit.dart';

sealed class DeveloperOpportunitiesState {
  const DeveloperOpportunitiesState();
}

final class DeveloperOpportunitiesInitial extends DeveloperOpportunitiesState {
  const DeveloperOpportunitiesInitial();
}

final class DeveloperOpportunitiesLoading extends DeveloperOpportunitiesState {
  const DeveloperOpportunitiesLoading();
}

final class DeveloperOpportunitiesLoaded extends DeveloperOpportunitiesState {

  const DeveloperOpportunitiesLoaded({
    required this.requests,
    required this.currentPage,
    required this.lastPage,
    this.totalCount,
    this.availableFilters,
    this.selectedOpportunityType,
    this.selectedCommunicationRequestType,
    this.selectedDeveloper,
    this.selectedCityId,
  });
  final List<DeveloperOpportunityRequestEntity> requests;
  final int currentPage;
  final int lastPage;
  final int? totalCount;
  final DeveloperOpportunityFiltersCollectionEntity? availableFilters;
  final DeveloperOpportunityFilterEntity? selectedOpportunityType;
  final DeveloperOpportunityFilterEntity? selectedCommunicationRequestType;
  final DeveloperOpportunityFilterEntity? selectedDeveloper;
  final int? selectedCityId;
}

final class DeveloperOpportunitiesError extends DeveloperOpportunitiesState {

  const DeveloperOpportunitiesError({required this.message});
  final String message;
}

final class DeveloperOpportunitiesDetailLoading
    extends DeveloperOpportunitiesState {
  const DeveloperOpportunitiesDetailLoading();
}

final class DeveloperOpportunitiesDetailLoaded extends DeveloperOpportunitiesState {

  const DeveloperOpportunitiesDetailLoaded({required this.request});
  final DeveloperOpportunityRequestEntity request;
}

final class DeveloperOpportunitiesDetailError extends DeveloperOpportunitiesState {

  const DeveloperOpportunitiesDetailError({required this.message});
  final String message;
}
