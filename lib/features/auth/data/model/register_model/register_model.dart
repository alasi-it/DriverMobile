class RegisterModel {
  String? userId;
  String? customerId;
  String? email;

  RegisterModel({this.userId, this.customerId, this.email});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    userId: json['userId'] as String?,
    customerId: json['customerId'] as String?,
    email: json['email'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'customerId': customerId,
    'email': email,
  };
}
