import 'dart:developer';

import 'package:app_management_system/shared/storages/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  bool isLoggedIn = false;
  bool isSessionExpired = false;
  String accessToken;
  String refreshToken;

  AuthController({
    this.accessToken = '',
    this.refreshToken = '',
  });

  /// Called upon startup. Load tokens from local storage
  void init () async {
    accessToken = (await SecureStorageHelper.read('accessToken')) ?? '';
    refreshToken = (await SecureStorageHelper.read('refreshToken')) ?? '';

    log('TOKENS NOT EMPTY: [${accessToken.isNotEmpty.toString()}, ${refreshToken.isNotEmpty.toString()}]');

    if (accessToken.isNotEmpty) {
      signIn();
    }
  }

  /// Do a log in and notify all listeners
  void signIn() async {
    isLoggedIn = true;
    notifyListeners();
  }

  /// Do a log out and notify all listeners
  void signOut() async {
    isLoggedIn = false;

    await SecureStorageHelper.delete('accessToken');
    await SecureStorageHelper.delete('refreshToken');

    notifyListeners();
  }

  /// Write `accessToken` and `refreshToken` to storage
  void write(String accessToken, String refreshToken) async {
    await SecureStorageHelper.write('accessToken', accessToken);
    await SecureStorageHelper.write('refreshToken', refreshToken);

    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }
}
