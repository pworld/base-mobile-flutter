class OTPPayloadModel {
  String phoneNumber;
  String phoneNumberCountryId;

  OTPPayloadModel({
    required this.phoneNumber,
    required this.phoneNumberCountryId
  });

  factory OTPPayloadModel.fromJson(Map<String, dynamic> json) {
    return OTPPayloadModel(
      phoneNumber: json['phone_number'] as String,
      phoneNumberCountryId: json['phone_number_country_id'] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'phone_number_country_id': phoneNumberCountryId,
    };
  }
}
