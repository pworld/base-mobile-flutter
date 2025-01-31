import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/otp_timer_notifier.dart';
import 'package:app_management_system/feature/auth/presentation/state/otp_timer_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final otpTimerProvider = StateNotifierProvider<OTPTimerNotifier, OTPTimerState>(
  (ref) {
    final authOtpProviderRef = ref.read(authOtpProvider);
    return OTPTimerNotifier(authOtpProviderRef);
  },
);
