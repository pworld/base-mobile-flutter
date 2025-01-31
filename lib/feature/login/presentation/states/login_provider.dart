import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data_access/services/login_service.dart';
import '../../data_access/usecases/login_usecase.dart';
import 'login_notifier.dart';
import 'login_state.dart';

// Login Provider
final loginServicesProvider = Provider<LoginServices>((ref) {
  return LoginServices();
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final loginServices = ref.read(loginServicesProvider);
  return LoginUseCase(loginServices);
});

final loginOTPStateNotifierProvider = StateNotifierProvider<LoginOTPStateNotifier, LoginOTPState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginOTPStateNotifier(loginUseCase);
});

final loginDriverStateNotifierProvider = StateNotifierProvider<LoginDriverStateNotifier, LoginDriverState>((ref) {
  final otpUseCase = ref.read(loginUseCaseProvider);
  return LoginDriverStateNotifier(otpUseCase);
});

final loginCompanyStateNotifierProvider = StateNotifierProvider<LoginCompanyStateNotifier, LoginCompanyState>((ref) {
  final loginCompanyUseCase = ref.read(loginUseCaseProvider);
  return LoginCompanyStateNotifier(loginCompanyUseCase);
});

final getLoginCompanyStateNotifierProvider = StateNotifierProvider<LoginCompaniesStateNotifier, LoginCompaniesState>((ref) {
  final loginCompanyUseCase = ref.read(loginUseCaseProvider);
  return LoginCompaniesStateNotifier(loginCompanyUseCase);
});