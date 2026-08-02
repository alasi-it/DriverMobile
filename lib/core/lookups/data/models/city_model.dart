class CityModel {
  String? id;
  String? name;
  String? countryId;

  CityModel({this.id, this.name, this.countryId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    final translations = json['cityTranslations'] as List?;

    String? cityName;
    if (translations != null && translations.isNotEmpty) {
      final item = translations.firstWhere(
        (e) => e['isDefault'] == true,
        orElse: () => translations.first,
      );
      cityName = item['name'];
    }

    return CityModel(
      id: json['city']?['id'],
      name: cityName,
      countryId: json['city']?['countryId'],
    );
  }
}
