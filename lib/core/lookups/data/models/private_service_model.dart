class PrivateServiceModel {
  String? id;
  String? serviceName;

  PrivateServiceModel({this.id, this.serviceName});

  factory PrivateServiceModel.fromJson(Map<String, dynamic> json) {
    final service = json['service'];

    return PrivateServiceModel(
      id: service?['id'] as String?,
      serviceName: service?['serviceName'] as String?,
    );
  }
}
