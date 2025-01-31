import 'package:app_management_system/core/authentication/auth_provider.dart';
import 'package:app_management_system/feature/auth/data/auth_source.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_notifier.dart';
import 'package:app_management_system/feature/auth/presentation/state/auth_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authSourceProvider = Provider((ref) {
  final authController = ref.read(authProvider);
  return AuthDataSource(authController: authController);
});

final authOtpProvider = StateNotifierProvider<AuthOTPNotifier, AuthOTPState>((ref) {
  return AuthOTPNotifier(ref.read(authSourceProvider));
});

final authLoginProvider = StateNotifierProvider<AuthLoginNotifier, AuthLoginState>((ref) {
  final authController = ref.read(authProvider);
  return AuthLoginNotifier(ref.read(authSourceProvider), authController);
});

final authCompanyListProvider = StateNotifierProvider<AuthCompanyListNotifier, AuthCompanyListState>((ref) {
  return AuthCompanyListNotifier(ref.read(authSourceProvider));
});

final authCompanyLoginProvider = StateNotifierProvider<AuthCompanyLoginNotifier, AuthCompanyLoginState>((ref) {
  return AuthCompanyLoginNotifier(ref.read(authSourceProvider));
});
