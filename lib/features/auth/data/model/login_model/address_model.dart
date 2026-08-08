class AddressModel {
  final String? id;
  final String? cityId;
  final String? countryId;
  final String? cityName;
  final String? countryName;
  final String addressLine;
  final String? buildingNumber;
  final bool isPrimary;
  final int type;

  const AddressModel({
    this.id,
    this.cityId,
    this.countryId,
    this.cityName,
    this.countryName,
    this.addressLine = '',
    this.buildingNumber,
    this.isPrimary = false,
    this.type = 0,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String?,
      cityId: json['cityId'] as String?,
      countryId: json['countryId'] as String?,
      cityName: json['city'] != null ? json['city']['name'] as String? : null,
      countryName: json['country'] != null
          ? json['country']['name'] as String?
          : null,
      addressLine: json['addressLine'] as String? ?? '',
      buildingNumber: json['buildingNumber'] as String?,
      isPrimary: json['isPrimary'] as bool? ?? false,
      type: json['type'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'cityId': cityId,
    'countryId': countryId,
    'addressLine': addressLine,
    'buildingNumber': buildingNumber,
    'isPrimary': isPrimary,
    'type': type,
  };
}
