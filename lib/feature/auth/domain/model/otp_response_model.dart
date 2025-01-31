class OTPResponseModel {
  String authOtpId;
  DateTime expiresAtUTC;
  String otpCode;

  OTPResponseModel({
    required this.authOtpId,
    required this.expiresAtUTC,
    required this.otpCode,
  });

  factory OTPResponseModel.fromJson(Map<String, dynamic> json) {
    return OTPResponseModel(
      authOtpId: json['auth_otp_id'] as String,
      expiresAtUTC: DateTime.parse(json['expires_at_utc'] as String),
      otpCode: json['otp_code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'auth_otp_id': authOtpId,
      'expires_at_utc': expiresAtUTC,
      'otp_code': otpCode,
    };
  }
}
