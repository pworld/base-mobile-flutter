class UserDataModel {
  String? firstName;
  String? lastName;
  String phoneNumber;
  String phoneCountryCode;
  String userId;
  String userName;
  String? tenantId;

  UserDataModel({
    this.firstName,
    this.lastName,
    required this.phoneNumber,
    required this.userId,
    required this.userName,
    this.tenantId,
    required this.phoneCountryCode,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String,
      tenantId: json['tenant_id'] as String?,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      phoneCountryCode: json['phone_number_country_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'tenant_id': tenantId ?? '',
      'user_id': userId,
      'user_name': userName,
      'phone_number_country_id': phoneCountryCode,
    };
  }
}
