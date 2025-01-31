import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config/app_config.dart';
import '../../core/services/failure.dart';
import '../storages/secure_storage.dart';

class BaseService {
  final String _endpoint = AppConfig.apiUrl;
  // final String _endpoint = 'http://127.0.0.1:5001';

  Future<Either<Failure, T>> request<T>({
    required String method,
    required String path,
    Map<String, dynamic>? payload,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {

    var completePath = '/api/driver/v1/$path';
    var uri = Uri.parse('$_endpoint$completePath');
    // 2. Environment Local

    // Initial request attempt
    var response = await _attemptRequest(method, uri, payload);

    // Check for unauthorized response (indicating possible expired token)
    if (response.statusCode == 401) {
      // Attempt to refresh the token
      final refreshTokenResult = await _refreshToken();

      if (refreshTokenResult.isRight()) {
        // Retry the original request with the new access token
        response = await _attemptRequest(method, uri, payload);
      } else {
        return Left(refreshTokenResult.swap().getOrElse(() => const ServerFailure(errorMessage: "Failed to refresh token")));
      }
    }

    // Process the response
    return _processResponse(response, fromJson);
  }

  Future<http.Response> _attemptRequest(String method, Uri uri, Map<String, dynamic>? payload) async {
    String? accessToken = await SecureStorageHelper.read('accessToken');
    final headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };
    print('method: $method');
    print('uri: $uri');
    print('accessToken: $accessToken');
    print('print requests ${jsonEncode(payload)}');
    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(uri, headers: headers, body: jsonEncode(payload));
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'PUT':
        return await http.put(uri, headers: headers, body: jsonEncode(payload));
      case 'DELETE':
        return await http.delete(uri, headers: headers);
      default:
        throw ArgumentError('Invalid HTTP method: $method');
    }
  }

  Future<Either<Failure, bool>> _refreshToken() async {
    String? refreshToken = await SecureStorageHelper.read('refreshToken');
    if (refreshToken == null) {
      return const Left(ServerFailure(errorMessage: "No refresh token available"));
    }

    var uri = Uri.parse('$_endpoint/authentication/refresh');
    var response = await http.post(uri, body: {'refreshToken': refreshToken});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Save new access token and refresh token
      await SecureStorageHelper.write('accessToken', data['accessToken']);
      await SecureStorageHelper.write('refreshToken', data['refreshToken']);
      return const Right(true);
    } else {
      return const Left(ServerFailure(errorMessage: "Failed to refresh token"));
    }
  }

  Either<Failure, T> _processResponse<T>(http.Response response, T Function(Map<String, dynamic>) fromJson) {
    // Check if the response status code indicates success (200 OK)
    if (response.statusCode == 200) {

      var responseData = jsonDecode(response.body);
      try {
        // Check if the response content-type is JSON
        final contentType = response.headers['content-type']?.toLowerCase() ?? '';
        if (contentType.contains('application/json')) {
          // Decode the JSON response body
          final Map<String, dynamic> jsonData = jsonDecode(response.body);

          // Check if the response body contains the expected 'data_access' field
          if (responseData['status_code'] == 200) {
            final data = jsonData['data'];
            print('response_data ${jsonEncode(data)}');
            // Use the provided fromJson function to convert the JSON map to desired data_access model
            return Right(fromJson(data));
          } else {
            // If the 'data_access' field is missing, return a ServerFailure
            return Left(ServerFailure(errorMessage: responseData['error']));
          }
        } else {
          // If the response is not in JSON format, return a ServerFailure
          return Left(ServerFailure(errorMessage: 'Expected JSON response, got: $contentType'));
        }
      } catch (e) {
        // Catch any errors during JSON parsing or data_access processing and return a ServerFailure
        return Left(ServerFailure(errorMessage: 'Error processing response: $e'));
      }
    } else {
      // If the response status code is not 200, attempt to extract an error message from the response body
      try {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final String errorMessage = jsonData['error'] as String? ?? 'Unknown error occurred';
        return Left(ServerFailure(errorMessage: errorMessage));
      } catch (e) {
        // If an error occurs during error message extraction, return a generic ServerFailure
        return Left(ServerFailure(errorMessage: 'Failed to parse error message: $e'));
      }
    }
  }
}
