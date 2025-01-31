import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:app_management_system/feature/auth/presentation/state/auth_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthViewNotifier extends StateNotifier<AuthViewState> {
  final AuthController authController;

  AuthViewNotifier({
    required this.authController,
  }): super(const AuthViewState());

  void set({
    String? accessToken,
    String? driverId,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? phoneNumberCountryCode,
    String? refreshToken,
    String? tenantId,
    String? userId,
    String? userName,
    String? otpId,
    String? otpCode,
  }) {
    state = state.copyWith(
      accessToken: accessToken,
      driverId: driverId,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      phoneNumberCountryCode: phoneNumberCountryCode,
      refreshToken: refreshToken,
      tenantId: tenantId,
      userId: userId,
      userName: userName,
      otpId: otpId,
      otpCode: otpCode,
    );
  }

  void setLoggedIn(bool loggedIn) {
    authController.isLoggedIn = loggedIn;
  }
}
