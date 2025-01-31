import 'package:flutter/widgets.dart';

@immutable
class AuthViewState {
  final String? accessToken;
  final String? driverId;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? phoneNumberCountryCode;
  final String? refreshToken;
  final String? tenantId;
  final String? userId;
  final String? userName;
  final String? otpId;
  final String? otpCode;

  const AuthViewState({
    this.accessToken,
    this.driverId,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.phoneNumberCountryCode,
    this.refreshToken,
    this.tenantId,
    this.userId,
    this.userName,
    this.otpId,
    this.otpCode,
  });

  AuthViewState copyWith({
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
    return AuthViewState(
      accessToken: accessToken ?? this.accessToken,
      driverId: driverId ?? this.driverId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberCountryCode:
          phoneNumberCountryCode ?? this.phoneNumberCountryCode,
      refreshToken: refreshToken ?? this.refreshToken,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      otpId: otpId ?? this.otpId,
      otpCode: otpCode ?? this.otpCode,
    );
  }
}
