class LanguageModel {
  final String? id;
  final String? name;

  LanguageModel({this.id, this.name});

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      LanguageModel(id: json['id'] as String?, name: json['name'] as String?);
}
