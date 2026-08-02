class SkillModel {
  String? id;
  String? name;

  SkillModel({this.id, this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    final translations = json['skillTranslations'] as List?;

    String? name;
    if (translations != null && translations.isNotEmpty) {
      final defaultItem = translations.firstWhere(
        (e) => e['isDefault'] == true,
        orElse: () => translations.first,
      );
      name = defaultItem['name'];
    }

    return SkillModel(id: json['skill']?['id'] as String?, name: name);
  }
}
