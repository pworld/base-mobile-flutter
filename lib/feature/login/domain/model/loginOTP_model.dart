// login otp verification model
class RequestauthenticationFormModel{
  String otpId;
  String otpCode;
  String phoneNumber;
  String phoneCountryCode;
  String userAgent;

  RequestauthenticationFormModel({
    required this.otpId,
    required this.otpCode,
    required this.phoneNumber,
    required this.phoneCountryCode,
    required this.userAgent,
  });

  factory RequestauthenticationFormModel.fromJson(Map<String, dynamic> json) {
    return RequestauthenticationFormModel(
      otpId: json['auth_otp_id'] as String,
      otpCode: json['otp_code'] as String,
      phoneNumber: json['phone_number'] as String,
      phoneCountryCode: json['phone_number_country_id'] as String,
      userAgent: json['user_agent'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'auth_otp_id': otpId,
      'otp_code': otpCode,
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneCountryCode,
      'user_agent': userAgent,
    };
  }
}

class ResponseAuthenticationModel {
  String accessToken;
  String? firstName;
  String? lastName;
  String phoneNumber;
  String? phoneCountryCode;
  String userId;
  String refreshToken;
  String userName;
  String tenantId;

  ResponseAuthenticationModel({
    required this.accessToken,
    this.firstName,
    this.lastName,
    required this.phoneNumber,
    required this.userId,
    required this.refreshToken,
    required this.userName,
    required this.tenantId,
    this.phoneCountryCode,
  });

  factory ResponseAuthenticationModel.fromJson(Map<String, dynamic> json) {
    return ResponseAuthenticationModel(
      accessToken: json['access_token'] as String,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String,
      refreshToken: json['refresh_token'] as String,
      tenantId: json['tenant_id'] as String,
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      phoneCountryCode: (json['phone_number_country_id'] ?? 'ID') as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneCountryCode,
      'refresh_token': refreshToken,
      'tenant_id': tenantId,
      'user_id': userId,
      'user_name': userName,
    };
  }
}
