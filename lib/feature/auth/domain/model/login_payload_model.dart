class LoginPayloadModel {
  String authOtpId;
  String otpCode;
  String phoneNumber;
  String? phoneNumberCountryId;
  String? userAgent;

  LoginPayloadModel({
    required this.authOtpId,
    required this.otpCode,
    required this.phoneNumber,
    this.phoneNumberCountryId,
    this.userAgent,
  });

  factory LoginPayloadModel.fromJson(Map<String, dynamic> json) {
    return LoginPayloadModel(
      authOtpId: json['auth_otp_id'] as String,
      otpCode: json['otp_code'] as String,
      phoneNumber: json['phone_number'] as String,
      phoneNumberCountryId: json['phone_number_country_id'] as String,
      userAgent: json['user_agent'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth_otp_id': authOtpId,
      'otp_code': otpCode,
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneNumberCountryId ?? '',
      'user_agent': userAgent ?? '',
    };
  }
}
