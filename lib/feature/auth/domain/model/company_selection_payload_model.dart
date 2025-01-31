class CompanySelectionPayloadModel {
  String refreshToken;
  String tenantId;

  CompanySelectionPayloadModel({
    required this.refreshToken,
    required this.tenantId,
  });

  factory CompanySelectionPayloadModel.fromJson(Map<String, dynamic> json) {
    return CompanySelectionPayloadModel(
      refreshToken: json['refresh_token'] as String,
      tenantId: json['tenant_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
      'tenant_id': tenantId,
    };
  }
}
