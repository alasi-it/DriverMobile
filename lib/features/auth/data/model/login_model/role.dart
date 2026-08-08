class Role {
  String? id;
  String? name;
  String? displayName;
  List<dynamic>? permissionNames;
  List<dynamic>? translations;

  Role({
    this.id,
    this.name,
    this.displayName,
    this.permissionNames,
    this.translations,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json['id'] as String?,
    name: json['name'] as String?,
    displayName: json['displayName'] as String?,
    permissionNames: json['permissionNames'] as List<dynamic>?,
    translations: json['translations'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'displayName': displayName,
    'permissionNames': permissionNames,
    'translations': translations,
  };
}
