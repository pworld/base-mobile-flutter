import 'package:app_management_system/core/authentication/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_view_notifier.dart';
import 'package:app_management_system/feature/auth/presentation/state/auth_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authViewProvider = StateNotifierProvider<AuthViewNotifier, AuthViewState>((ref) {
  final authController = ref.read(authProvider);
  return AuthViewNotifier(authController: authController);
});
