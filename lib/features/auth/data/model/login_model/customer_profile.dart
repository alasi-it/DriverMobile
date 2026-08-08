import 'package:isnad_worker/features/auth/data/model/login_model/address_model.dart';
import 'package:isnad_worker/features/auth/data/model/login_model/contact_model.dart';

class CustomerProfile {
  String? id;
  String? userId;
  String? nameAr;
  String? email;
  String? gender;
  String? identityType;
  String? identityNumber;
  String? type;
  bool? isActive;
  List<AddressModel>? addresses;
  List<ContactModel>? contacts;

  CustomerProfile({
    this.id,
    this.userId,
    this.nameAr,
    this.email,
    this.gender,
    this.identityType,
    this.identityNumber,
    this.type,
    this.isActive,
    this.addresses,
    this.contacts,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      nameAr: json['nameAr'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      identityType: json['identityType'] as String?,
      identityNumber: json['identityNumber'] as String?,
      type: json['type'] as String?,
      isActive: json['isActive'] as bool?,
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      contacts: (json['contacts'] as List<dynamic>?)
          ?.map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'nameAr': nameAr,
    'email': email,
    'gender': gender,
    'identityType': identityType,
    'identityNumber': identityNumber,
    'type': type,
    'isActive': isActive,
    'addresses': addresses,
    'contacts': contacts,
  };
}
