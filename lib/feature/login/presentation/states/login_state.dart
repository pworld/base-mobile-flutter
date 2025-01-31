import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/login_model.dart';
import '../../domain/model/logincompany_model.dart';

class LoginOTPState {
  final AsyncValue<ResponseLoginFormModel> successData;

  LoginOTPState({required this.successData});

  LoginOTPState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class LoginDriverState {
  final AsyncValue<ResponseAuthenticationModel> successData;

  LoginDriverState({required this.successData});

  LoginDriverState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class LoginCompanyState {
  final AsyncValue<ResponseAuthenticationModel> successData;

  LoginCompanyState({required this.successData});

  LoginCompanyState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}

class LoginCompaniesState {
  final AsyncValue<ResponseGetCompaniesModel> successData;

  LoginCompaniesState({required this.successData});

  LoginCompaniesState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}