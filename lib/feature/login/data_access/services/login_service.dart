import 'package:dartz/dartz.dart';
import 'package:app_management_system/core/services/failure.dart';
import 'package:app_management_system/shared/services/base_services.dart';

import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/login_model.dart';
import '../../domain/model/logincompany_model.dart';


class LoginServices extends BaseService {
  // Future for Login Phone Number
  Future<Either<Failure, ResponseLoginFormModel>> loginOTP(RequestLoginOTPFormModel payload) async {
    return request<ResponseLoginFormModel>(
      method: 'POST',
      path: 'auth/login-otp',
      payload: payload.toJson(),
      fromJson: (json) => ResponseLoginFormModel.fromJson(json),
    );
  }

  // Future for OTP verification
  Future<Either<Failure, ResponseAuthenticationModel>> loginDriver(RequestauthenticationFormModel payload) async {
    return request<ResponseAuthenticationModel>(
      method: 'POST',
      path: 'auth/login',
      payload: payload.toJson(),
      fromJson: (json) => ResponseAuthenticationModel.fromJson(json),
    );
  }

  // Future for Get Company
  Future<Either<Failure, ResponseGetCompaniesModel>> getCompanies() async {
    return request<ResponseGetCompaniesModel>(
      method: 'GET',
      path: 'auth/companies',
      payload: {},
      fromJson: (json) => ResponseGetCompaniesModel.fromJson(json),
    );
  }

  // Future for Login Company
  Future<Either<Failure, ResponseAuthenticationModel>> loginCompany(RequestLoginCompanyModel payload) async {
    return request<ResponseAuthenticationModel>(
      method: 'POST',
      path: 'auth/select-company',
      payload: payload.toJson(),
      fromJson: (json) => ResponseAuthenticationModel.fromJson(json),
    );
  }
}
