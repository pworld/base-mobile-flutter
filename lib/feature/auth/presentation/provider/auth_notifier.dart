import 'dart:convert';

import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:app_management_system/feature/auth/data/auth_source.dart';
import 'package:app_management_system/feature/auth/domain/model/company_selection_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/login_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/login_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_payload_model.dart';
import 'package:app_management_system/feature/auth/presentation/state/auth_state.dart';
import 'package:app_management_system/shared/storages/shared_preferences_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthOTPNotifier extends StateNotifier<AuthOTPState> {
  final AuthDataSource source;

  AuthOTPNotifier(this.source) : super(AuthOTPState.initial());

  Future<void> generateOTP(OTPPayloadModel payload) async {
    state = AuthOTPState.copyWith(response: state.response, loading: true);

    final response = await source.generateOTP(payload);
    state = AuthOTPState(response: response);
  }

  void resetState() {
    state = AuthOTPState.initial();
  }
}

class AuthLoginNotifier extends StateNotifier<AuthLoginState> {
  final AuthDataSource source;
  final AuthController authController;

  AuthLoginNotifier(this.source, this.authController)
      : super(AuthLoginState.initial());

  Future<void> login(LoginPayloadModel payload) async {
    state = AuthOTPState.copyWith(response: state.response, loading: true);
    final response = await source.login(payload);

    if (response.data != null) {
      saveToken(response.data!, false);
    }

    state = AuthLoginState(response: response);
  }

  void resetState() {
    state = AuthLoginState.initial();
  }

  Future<void> saveToken(LoginResponseModel data, bool? signIn) async {
    String userDataJson = jsonEncode(data.toJson());
    authController.write(data.accessToken, data.refreshToken);

    if (signIn != null && signIn == true) {
      await SharedPreferencesHelper.write('userData', userDataJson);
      authController.signIn();
    }
  }
}

class AuthCompanyListNotifier extends StateNotifier<AuthCompanyListState> {
  final AuthDataSource source;

  AuthCompanyListNotifier(this.source) : super(AuthCompanyListState.initial());

  Future<void> getCompanies() async {
    state = AuthOTPState.copyWith(response: state.response, loading: true);
    final response = await source.getCompanies();
    state = AuthCompanyListState(response: response);
  }
}

class AuthCompanyLoginNotifier extends StateNotifier<AuthCompanyLoginState> {
  final AuthDataSource source;

  AuthCompanyLoginNotifier(this.source)
      : super(AuthCompanyLoginState.initial());

  Future<void> selectCompany(CompanySelectionPayloadModel payload) async {
    state = AuthOTPState.copyWith(response: state.response, loading: true);
    final response = await source.selectCompany(payload);
    state = AuthCompanyLoginState(response: response);
  }
}
