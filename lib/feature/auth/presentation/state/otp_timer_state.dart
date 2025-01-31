import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

@immutable
class OTPTimerState {
  final int totalSeconds;
  final bool timerActive;

  const OTPTimerState({
    required this.totalSeconds,
    required this.timerActive,
  });

  /// Change the timer state
  OTPTimerState copyWith({int? seconds, bool? timerActive}) {
    return OTPTimerState(
      totalSeconds: seconds ?? totalSeconds,
      timerActive: timerActive ?? this.timerActive,
    );
  }

  /// Get formatted countdown in `mm:ss`
  String getFormatted() {
    final DateTime dt = DateTime.fromMillisecondsSinceEpoch(
      totalSeconds * 1000,
    );
    return DateFormat.ms().format(dt);
  }
}
