import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data_access/usecases/login_usecase.dart';
import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/login_model.dart';
import '../../domain/model/logincompany_model.dart';
import 'login_state.dart';

class LoginOTPStateNotifier extends StateNotifier<LoginOTPState> {
  final LoginUseCase _loginUseCase;

  LoginOTPStateNotifier(this._loginUseCase) : super(LoginOTPState.initial());

  Future<void> loginOTP(RequestLoginOTPFormModel requestData) async {
    state = LoginOTPState(successData: const AsyncValue.loading());
    final response = await _loginUseCase.loginOTP(requestData);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = LoginOTPState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = LoginOTPState(successData: AsyncValue.data(success));
      },
    );
  }
}

class LoginDriverStateNotifier extends StateNotifier<LoginDriverState> {
  final LoginUseCase _loginUseCase;

  LoginDriverStateNotifier(this._loginUseCase) : super(LoginDriverState.initial());

  Future<void> loginDriver(RequestauthenticationFormModel requestData) async {
    state = LoginDriverState(successData: const AsyncValue.loading());
    final response = await _loginUseCase.loginDriver(requestData);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = LoginDriverState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = LoginDriverState(successData: AsyncValue.data(success));
      },
    );
  }

  Future<bool> driverLogout() async {
    return await _loginUseCase.driverLogout();
  }
}

class LoginCompanyStateNotifier extends StateNotifier<LoginCompanyState> {
  final LoginUseCase _loginCompanyUseCase;

  LoginCompanyStateNotifier(this._loginCompanyUseCase) : super(LoginCompanyState.initial());

  Future loginCompany(RequestLoginCompanyModel requestData) async {
    state = LoginCompanyState(successData: const AsyncValue.loading());
    final response = await _loginCompanyUseCase.loginCompany(requestData);
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = LoginCompanyState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = LoginCompanyState(successData: AsyncValue.data(success));
      },
    );
  }
}

class LoginCompaniesStateNotifier extends StateNotifier<LoginCompaniesState> {
  final LoginUseCase _loginCompanyUseCase;

  LoginCompaniesStateNotifier(this._loginCompanyUseCase) : super(LoginCompaniesState.initial());

  Future getCompanies() async {
    state = LoginCompaniesState(successData: const AsyncValue.loading());
    final response = await _loginCompanyUseCase.getCompanies();
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = LoginCompaniesState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = LoginCompaniesState(successData: AsyncValue.data(success));
      },
    );
  }
}