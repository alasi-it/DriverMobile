class ContactModel {
  String? id;
  String? type;
  String? value;
  String? name;
  bool? isPrimary;

  ContactModel({this.id, this.type, this.value, this.name, this.isPrimary});

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      value: json['value'] as String?,
      name: json['name'] as String?,
      isPrimary: json['isPrimary'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (type != null) 'type': type,
    if (value != null) 'value': value,
    if (name != null) 'name': name,
    if (isPrimary != null) 'isPrimary': isPrimary,
  };
}
