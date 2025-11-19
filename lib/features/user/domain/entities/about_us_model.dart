class AboutUsModel {
  AboutUsModel({
    required this.logo,
    required this.description,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      logo: json['logo'] as String,
      description: json['description'] as String,
    );
  }
  final String logo;
  final String description;
}
