import 'dart:convert';
import 'dart:developer';

import 'package:app_management_system/config/app_config.dart';
import 'package:app_management_system/core/authentication/auth_controller.dart';
import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/shared/storages/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class HTTPService {
  final String _endpoint = '${AppConfig.apiUrl}/api/driver/v1';
  final String _refreshTokenPath = 'auth/refresh-token';

  /// Do a http request
  ///
  /// ### Returns
  /// When the request is successfully done, the data will be stored under
  /// `HTTPResponseModel.response`, and the status code should be `2xx` or `3xx`
  ///
  /// ### Exception
  /// `HTTPResponseModel.response` will be `null` if the request contains an error,
  /// so you can do a null checks on this to handle errors.
  Future<ResponseStateModel<T>> request<T>({
    required HTTPMethod method,
    required String path,
    Map<String, dynamic>? payload,
    required AuthController authController,
    required T Function(Map<String, dynamic> json) fromJson,
    Function()? onSessionExpired,
  }) async {
    try {
      log('===== AUTH CONTROLLER STATE ===========');
      log('accessToken: ${authController.accessToken}');
      log('refreshToken: ${authController.refreshToken}');
      log('isLoggedIn: ${authController.isLoggedIn}');
      log('isSessionExpired: ${authController.isSessionExpired}');

      Response response = await _request(
        method: method,
        path: path,
        payload: payload,
        token: authController.accessToken,
      );

      // If unauthorized to do request, try to request a token refresh
      if (HTTPStatus.unauthorized.equals(response.statusCode)) {
        String? newToken = await _refreshToken(authController);

        // If no refreshToken is available, return an error on HTTPResponseModel,
        // also the app must throw user to the login screen.
        if (newToken == null) {
          onSessionExpired?.call();
          authController.signOut();
          return const ResponseStateModel(
            status: HTTPStatus.arbitraryError,
            errorMessage: 'Failed to refresh access token.',
          );
        }

        response = await _request(
          method: method,
          path: path,
          payload: payload,
          token: newToken, // make sure to use the new accessToken
        );
      }

      return _processResponse(
        response: response,
        fromJson: fromJson,
      );
    } catch (e) {
      // Catch any exception, return as arbitraryError on HTTPResponseModel
      return ResponseStateModel(
        status: HTTPStatus.arbitraryError,
        errorMessage: e.toString(),
      );
    }
  }

  Future<Response> _request({
    required HTTPMethod method,
    required String path,
    Map<String, dynamic>? payload,
    String? token,
  }) async {
    Uri uri = Uri.parse('$_endpoint/$path');
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    if (!kReleaseMode) {
      log('== REQUEST =================');
      log('method: $method');
      log('uri: $uri');
      log('accessToken: $token');
      log('request: ${jsonEncode(payload)}');
      log('============================');
    }

    switch (method) {
      case HTTPMethod.get:
        return await get(uri, headers: headers);
      case HTTPMethod.post:
        return await post(uri, headers: headers, body: jsonEncode(payload));
      case HTTPMethod.put:
        return await put(uri, headers: headers, body: jsonEncode(payload));
      case HTTPMethod.delete:
        return await delete(uri, headers: headers);
    }
  }

  /// Process the response
  ///
  /// ### Returns
  /// When the response is successfully processed, the data will be stored under
  /// `HTTPResponseModel.response`, and the status code should be `2xx` or `3xx`
  ///
  /// ### Exceptions
  /// Most API errors is handled and stored under
  /// `HTTPResponseModel.errorMessage` and `HTTPResponseModel.errorResponse`
  Future<ResponseStateModel<T>> _processResponse<T>({
    required Response response,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    final contentType = response.headers['content-type']?.toLowerCase() ?? '';
    HTTPStatus status = HTTPStatus.from(response.statusCode);

    // When http status is not 200 or 201,
    // store the error on HTTPResponseModel.
    if (status != HTTPStatus.ok) {
      if (!kReleaseMode) {
        log('== RESPONSE (ERROR) ========');
        log('status: ${response.statusCode}');
        log('response: ${response.body}');
        log('============================');
      }

      if (contentType.contains('text/plain')) {
        return ResponseStateModel(
          status: status,
          errorMessage: response.body,
          errorResponse: {'raw': response.body},
        );
      }

      try {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return ResponseStateModel(
          status: status,
          errorMessage: jsonData['error'] as String,
          errorResponse: jsonData,
        );
      } catch (e) {
        return ResponseStateModel(
          status: status,
          errorMessage:
              'Failed to parse response body. Check errorResponse.raw inside the HTTPResponseModel.',
          errorResponse: {'raw': e, 'responseBody': response.body},
        );
      }
    }

    // When contentType is text, it's probably an error,
    // store the error on HTTPResponseModel.
    if (contentType.contains('text/plain')) {
      if (!kReleaseMode) {
        log('== RESPONSE (ERROR) ========');
        log('status: ${response.statusCode}');
        log('response: ${response.body}');
        log('============================');
      }

      return ResponseStateModel(
        status: status,
        errorMessage: response.body,
        errorResponse: {'raw': response.body},
      );
    }

    // When contentType is anything but application/json,
    // store the error on HTTPResponseModel.
    if (!contentType.contains('application/json')) {
      if (!kReleaseMode) {
        log('== RESPONSE (ERROR) ========');
        log('status: ${response.statusCode}');
        log('response: ${response.body}');
        log('============================');
      }

      return ResponseStateModel(
        status: status,
        errorMessage:
            'Unsupported content type, received "$contentType", also check errorResponse.raw inside the HTTPResponseModel',
        errorResponse: {'raw': response.body, 'responseBody': response.body},
      );
    }

    // Try to parse the data
    // throw error when failed
    try {
      var body = jsonDecode(response.body);

      if (body['status_code'] == 200) {
        final data = body['data'];

        if (!kReleaseMode) {
          log('== RESPONSE ================');
          log('status: ${response.statusCode}');
          log('response: ${jsonEncode(data)}');
          log('============================');
        }

        return ResponseStateModel(
          status: status,
          data: fromJson(data),
        );
      } else {
        return ResponseStateModel(
          status: status,
          errorMessage: body['error'] as String,
          errorResponse: {'raw': body},
        );
      }
    } catch (e) {
      return ResponseStateModel(
        status: status,
        errorMessage:
            'Failed to parse response body. Check errorResponse.raw inside the HTTPResponseModel.',
        errorResponse: {'raw': e, 'responseBody': response.body},
      );
    }
  }

  Future<String?> _refreshToken(
    AuthController authController,
  ) async {
    if (authController.refreshToken.isEmpty) {
      return null;
    }

    Uri uri = Uri.parse('$_endpoint/$_refreshTokenPath');
    Response response = await post(
      uri,
      body: {
        'refreshToken': authController.refreshToken,
      },
    );

    if (HTTPStatus.ok.equals(response.statusCode)) {
      return null;
    }

    var data = jsonDecode(response.body);
    String token = data['accessToken'] as String;

    await SecureStorageHelper.write('accessToken', data['accessToken']);
    await SecureStorageHelper.write('refreshToken', data['refreshToken']);

    return token;
  }
}
