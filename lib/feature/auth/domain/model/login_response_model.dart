class LoginResponseModel {
  String accessToken;
  String driverId;
  String firstName;
  String lastName;
  String phoneNumber;
  String? phoneNumberCountryCode;
  String refreshToken;
  String userId;
  String userName;
  String? tenantId;

  LoginResponseModel({
    required this.accessToken,
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.phoneNumberCountryCode,
    required this.refreshToken,
    required this.userId,
    required this.userName,
    this.tenantId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'] as String,
      driverId: json['driver_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phoneNumber: json['phone_number'] as String,
      phoneNumberCountryCode: json['phone_number_country_code'] as String?,
      refreshToken: json['refresh_token'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      tenantId: json['tenant_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'driver_id': driverId,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneNumberCountryCode ?? '',
      'refresh_token': refreshToken,
      'user_id': userId,
      'user_name': userName,
      'tenant_id': tenantId ?? '',
    };
  }
}
