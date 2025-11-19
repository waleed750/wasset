class wassetSpecialization {
  int? id;
  String? name;

  wassetSpecialization({this.id, this.name});

  factory wassetSpecialization.fromJson(Map<String, dynamic> json) {
    return wassetSpecialization(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
