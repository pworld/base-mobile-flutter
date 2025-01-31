import 'dart:convert';

import 'package:app_management_system/shared/storages/secure_storage.dart';
import 'package:app_management_system/shared/storages/shared_preferences_storage.dart';
import '../model/loginOTP_model.dart';
import '../model/auth_model.dart';

class UserStorage {
  /// Writes access and refresh tokens to secure storage
  static Future<void> writeTokensToSecureStorage(String accessToken, String refreshToken) async {
    await SecureStorageHelper.write('accessToken', accessToken);
    await SecureStorageHelper.write('refreshToken', refreshToken);
  }
  /// Get data_access from secure storage
  static Future<Map<String, dynamic>?> readSecureStorageData(String key) async {
    final jsonData = await SecureStorageHelper.read(key);
    if (jsonData != null) {
      return jsonDecode(jsonData);
    }
    return null;
  }
  /// Stores user data_access in shared preferences
  static Future<void> storeUserData(ResponseAuthenticationModel userData) async {

    UserDataModel userDataMap = UserDataModel(
      firstName: userData.firstName,
      lastName: userData.lastName,
      phoneNumber: userData.phoneNumber,
      phoneCountryCode: userData.phoneCountryCode ?? 'ID',
      userId: userData.userId,
      userName: userData.userName,
      tenantId: userData.tenantId,
    );

    // Convert userDataMap to a JSON string
    String userDataJson = jsonEncode(userDataMap.toJson());
    await SharedPreferencesHelper.write('userData', userDataJson);
  }

  /// Reads and returns user data_access from shared preferences
  static Future<UserDataModel?> readUserData() async {
    String? userDataJson = await SharedPreferencesHelper.read('userData');
    if (userDataJson != null) {
      // Convert the JSON string back to a Map<String, dynamic>
      Map<String, dynamic> userMap = jsonDecode(userDataJson);

      // Use the fromJson constructor to create an instance of UserDataModel
      return UserDataModel.fromJson(userMap);
    }
    return null;
  }

  // Method to clear all user data
  static Future<bool> clearUserData() async {
    try {
      // Try to clear data from both secure storage and shared preferences
      await SecureStorageHelper.clear();
      await SharedPreferencesHelper.clear();
      // If no exception was thrown, return true
      return true;
    } catch (e) {
      // If an exception was thrown, log it and return false
      print("Error clearing user data: $e");
      return false;
    }
  }
}
