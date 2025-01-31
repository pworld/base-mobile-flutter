import 'dart:async';

import 'package:app_management_system/feature/auth/presentation/state/auth_state.dart';
import 'package:app_management_system/feature/auth/presentation/state/otp_timer_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OTPTimerNotifier extends StateNotifier<OTPTimerState> {
  final AuthOTPState authOtpState;

  OTPTimerNotifier(this.authOtpState)
      : super(const OTPTimerState(totalSeconds: 0, timerActive: false)) {
    startTimer(authOtpState.response.data?.expiresAtUTC ??
        DateTime.now().add(const Duration(minutes: 2)));
  }

  Timer? _timer;

  /// Start a new countdown
  /// ### Cautions
  /// Will stop currently running timer.
  void startTimer(DateTime time) {
    if (_timer != null && _timer!.isActive) stopTimer();

    final initialCountdown = time.difference(DateTime.now()).inSeconds;

    setState(
      seconds: initialCountdown,
      timerActive: true,
    );

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state.totalSeconds > 0) {
          setState(seconds: state.totalSeconds - 1);
        } else {
          stopTimer();
        }
      },
    );
  }

  /// Check if the timer is active or not
  bool isTimerActive() {
    if (_timer == null) return false;

    return _timer!.isActive;
  }

  /// Stop the current timer
  void stopTimer() {
    if (_timer == null) return;

    print('TIMER DEACTIVATED?????????');
    setState(timerActive: false);
    _timer!.cancel();
  }

  /// Change the timer state
  void setState({int? seconds, bool? timerActive}) {
    state = state.copyWith(
      seconds: seconds,
      timerActive: timerActive,
    );
  }
}
