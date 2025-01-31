import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/feature/auth/domain/model/company_list_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/login_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_response_model.dart';

class AuthState<T> {
  final ResponseStateModel<T> response;
  bool loading = false;

  AuthState({required this.response, this.loading = false});

  AuthState.initial() : response = ResponseStateModel.initial();

  static AuthState<U> copyWith<U>({
    required ResponseStateModel<U> response,
    bool? loading,
  }) {
    return AuthState<U>(
      response: response,
      loading: loading ?? false,
    );
  }
}

typedef AuthOTPState = AuthState<OTPResponseModel>;
typedef AuthLoginState = AuthState<LoginResponseModel>;
typedef AuthCompanyListState = AuthState<List<CompanyListResponseModel>>;
typedef AuthCompanyLoginState = AuthState<LoginResponseModel>;
