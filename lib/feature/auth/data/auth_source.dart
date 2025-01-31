import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/feature/auth/domain/model/company_list_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/company_selection_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/login_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/login_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_response_model.dart';
import 'package:app_management_system/core/http/http_service.dart';

typedef AsyncHTTPResponseModel<T> = Future<ResponseStateModel<T>>;

class AuthDataSource extends HTTPService {
  final AuthController authController;

  AuthDataSource({required this.authController});

  /// Endpoint for Generating OTP Code
  AsyncHTTPResponseModel<OTPResponseModel> generateOTP(OTPPayloadModel payload) async {
    return request<OTPResponseModel>(
      method: HTTPMethod.post,
      path: 'auth/login-otp',
      payload: payload.toJson(),
      authController: authController,
      fromJson: OTPResponseModel.fromJson,
      onSessionExpired: authController.signOut
    );
  }

  /// Endpoint for Login via OTP Code
  AsyncHTTPResponseModel<LoginResponseModel> login(LoginPayloadModel payload) async {
    return request<LoginResponseModel>(
      method: HTTPMethod.post,
      path: 'auth/login',
      payload: payload.toJson(),
      authController: authController,
      fromJson: LoginResponseModel.fromJson,
      onSessionExpired: authController.signOut
    );
  }

  /// Endpoint to get Company List
  AsyncHTTPResponseModel<List<CompanyListResponseModel>> getCompanies() async {
    return request<List<CompanyListResponseModel>>(
      method: HTTPMethod.get,
      path: 'auth/companies',
      payload: {},
      authController: authController,
      fromJson: (json) {
        
        return List.empty();
      },
      onSessionExpired: authController.signOut
    );
  }

  /// Endpoint for Selecting Company
  AsyncHTTPResponseModel<LoginResponseModel> selectCompany(CompanySelectionPayloadModel payload) async {
    return request<LoginResponseModel>(
      method: HTTPMethod.post,
      path: 'auth/select-company',
      payload: payload.toJson(),
      authController: authController,
      fromJson: LoginResponseModel.fromJson,
      onSessionExpired: authController.signOut
    );
  }
}
