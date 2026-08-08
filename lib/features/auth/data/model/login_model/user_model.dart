import 'customer_profile.dart';
import 'role.dart';

class UserModel {
  String? userName;
  String? name;
  String? email;
  DateTime? dateOfBirth;
  String? gender;
  String? phoneNumber;
  String? profilePicture;

  bool? isActive;
  String? userType;
  List<Role>? roles;
  String? identityNumber;
  CustomerProfile? customerProfile;
  String? id;
  DateTime? createdDate;
  bool get isProfileComplete =>
      name != null &&
      name!.isNotEmpty &&
      email != null &&
      email!.isNotEmpty &&
      phoneNumber != null &&
      phoneNumber!.isNotEmpty &&
      identityNumber != null &&
      identityNumber!.isNotEmpty;
  bool get checkProfile =>
      isProfileComplete && (customerProfile?.addresses?.isNotEmpty ?? false);
  UserModel({
    this.userName,
    this.name,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.isActive,
    this.userType,
    this.roles,
    this.identityNumber,
    this.customerProfile,
    this.id,
    this.createdDate,
    this.profilePicture,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    userName: json['userName'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    gender: json['gender'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    isActive: json['isActive'] as bool?,
    userType: json['userType'] as String?,
    roles: (json['roles'] as List<dynamic>?)
        ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
        .toList(),
    identityNumber: json['identityNumber'] as String?,
    profilePicture: json['profilePicture'] as String?,
    customerProfile: json['customerProfile'] == null
        ? null
        : CustomerProfile.fromJson(
            json['customerProfile'] as Map<String, dynamic>,
          ),
    id: json['id'] as String?,
    createdDate: json['createdDate'] == null
        ? null
        : DateTime.parse(json['createdDate'] as String),
  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'name': name,
    'email': email,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'gender': gender,
    'phoneNumber': phoneNumber,
    'isActive': isActive,
    'userType': userType,
    'roles': roles?.map((e) => e.toJson()).toList(),
    'identityNumber': identityNumber,
    'customerProfile': customerProfile?.toJson(),
    'id': id,
    'createdDate': createdDate?.toIso8601String(),
  };
}
