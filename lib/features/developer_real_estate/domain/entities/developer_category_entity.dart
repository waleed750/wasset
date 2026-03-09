class DeveloperCategoryEntity {

  DeveloperCategoryEntity({
    required this.key,
    required this.label,
    this.projectCount,
  });
  final String key;
  final String label;
  final int? projectCount;
}
