class RequestLoginCompanyModel {
  final String RefreshToken;
  final String TenantId;

  RequestLoginCompanyModel({
    required this.RefreshToken,
    required this.TenantId
  });

  factory RequestLoginCompanyModel.fromJson(Map<String, dynamic> json) {
    return RequestLoginCompanyModel(
      RefreshToken: json['refresh_token'] as String,
      TenantId: json['logo_url'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'refresh_token': RefreshToken,
      'logo_url': TenantId,
    };
  }
}

class CompanyModel {
  String CompanyName;
  String TenantId;
  String LogoUrl;

  CompanyModel({
    required this.CompanyName,
    required this.TenantId,
    required this.LogoUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      CompanyName: json['company_name'] as String,
      TenantId: json['tenant_id'] as String,
      LogoUrl: json['logo_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': CompanyName,
      'tenant_id': TenantId,
      'logo_url': LogoUrl,
    };
  }
}

class ResponseGetCompaniesModel {
  List<CompanyModel> companies;

  ResponseGetCompaniesModel({
    required this.companies,
  });

  factory ResponseGetCompaniesModel.fromJson(Map<String, dynamic> json) {
    var list = json['companies'] as List;
    List<CompanyModel> companyList = list.map((i) => CompanyModel.fromJson(i)).toList();
    return ResponseGetCompaniesModel(
      companies: companyList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companies': companies.map((company) => company.toJson()).toList(),
    };
  }
}

class ResponseLoginCompanyModel {
  String CompanyName;
  String TenantId;
  String LogoUrl;

  ResponseLoginCompanyModel({
    required this.CompanyName,
    required this.TenantId,
    required this.LogoUrl,
  });

  factory ResponseLoginCompanyModel.fromJson(Map<String, dynamic> json) {
    return ResponseLoginCompanyModel(
      CompanyName: json['company_name'] as String,
      TenantId: json['tenant_id'] as String,
      LogoUrl: json['logo_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_name': CompanyName,
      'tenant_id': TenantId,
      'logo_url': LogoUrl,
    };
  }
}