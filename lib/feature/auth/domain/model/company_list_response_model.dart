class CompanyListResponseModel {
  String companyName;
  String driverId;
  String tenantId;

  CompanyListResponseModel({
    required this.companyName,
    required this.driverId,
    required this.tenantId,
  });

  factory CompanyListResponseModel.fromJson(Map<String, dynamic> json) {
    return CompanyListResponseModel(
      companyName: json['company_name'] as String,
      driverId: json['driver_id'] as String,
      tenantId: json['tenant_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': companyName,
      'driver_id': driverId,
      'tenant_id': tenantId,
    };
  }
}
