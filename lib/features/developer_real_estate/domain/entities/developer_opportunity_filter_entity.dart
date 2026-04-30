class DeveloperOpportunityFilterEntity {

  DeveloperOpportunityFilterEntity({
    required this.id,
    required this.name,
  });
  final int id;
  final String name;
}

class DeveloperOpportunityFiltersCollectionEntity {

  DeveloperOpportunityFiltersCollectionEntity({
    required this.opportunityTypes,
    required this.communicationRequestTypes,
    required this.developers,
  });
  final List<DeveloperOpportunityFilterEntity> opportunityTypes;
  final List<DeveloperOpportunityFilterEntity> communicationRequestTypes;
  final List<DeveloperOpportunityFilterEntity> developers;
}
