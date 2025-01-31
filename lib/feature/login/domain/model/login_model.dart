// login phone number model
class RequestLoginOTPFormModel{
  String phoneNumber;
  String phoneCountryCode;
  String? otpCode;

  RequestLoginOTPFormModel({
    required this.phoneNumber,
    required this.phoneCountryCode,
    this.otpCode,
  });

  factory RequestLoginOTPFormModel.fromJson(Map<String, dynamic> json) {
    return RequestLoginOTPFormModel(
      phoneNumber: json['phone_number'] as String,
      phoneCountryCode: json['phone_number_country_id'] as String,
      otpCode: json['otp_code'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneCountryCode,
      'otp_code': otpCode,
    };
  }
}

class ResponseLoginFormModel{
  String otpId;
  DateTime expiresAtUtc;
  String? phoneNumber;
  String? phoneCountryCode;
  String? otpCode;

  ResponseLoginFormModel({
    required this.otpId,
    required this.expiresAtUtc,
    this.phoneNumber,
    this.phoneCountryCode,
    this.otpCode
  });

  factory ResponseLoginFormModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginFormModel(
      otpId: json['auth_otp_id'] as String,
      expiresAtUtc: DateTime.parse(json['expires_at_utc'] as String),
      phoneNumber: json['phone_number'] as String?,
      phoneCountryCode: json['phone_number_country_id'] as String?,
      otpCode: json['otp_code'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'auth_otp_id': otpId,
      'expires_at_utc': expiresAtUtc,
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneCountryCode,
      'otp_code':otpCode
    };
  }
}
