class CountryModel {
  String? id;
  String? nationalityName;
  String? name;

  CountryModel({this.id, this.nationalityName, this.name});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final translations = json['countryTranslations'] as List?;

    String? nationality;
    String? countryName;
    if (translations != null && translations.isNotEmpty) {
      final item = translations.firstWhere(
        (e) => e['isDefault'] == true,
        orElse: () => translations.first,
      );
      nationality = item['nationalityName'];
      countryName = item['countryName'];
    }

    return CountryModel(
      id: json['country']?['id'],
      nationalityName: nationality,
      name: countryName,
    );
  }
}
