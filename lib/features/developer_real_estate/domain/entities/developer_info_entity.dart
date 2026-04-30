class DeveloperInfoEntity {
  const DeveloperInfoEntity({
    required this.id,
    required this.name,
    this.responsibleName,
    this.responsibleMobile,
    this.logo,
  });

  final int id;
  final String name;
  final String? responsibleName;
  final String? responsibleMobile;
  final String? logo;
}
