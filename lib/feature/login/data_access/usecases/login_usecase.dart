import 'package:app_management_system/core/services/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/model/logincompany_model.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/login_model.dart';
import '../services/login_service.dart';


class LoginUseCase {
  final LoginServices _loginServices;

  LoginUseCase(this._loginServices);

  // Request for Login OTP
  Future<Either<Failure, ResponseLoginFormModel>> loginOTP(RequestLoginOTPFormModel payload) async {
    var result = await _loginServices.loginOTP(payload);
    return result.fold(
          (failure) {
        // Handle failure case
        print("Failed with error: ${failure.toString()}");
        return Left(failure); // return the failure
      },
          (response) async {
            // Perform side effects on success
            response.phoneNumber = payload.phoneNumber;
            response.phoneCountryCode = payload.phoneCountryCode;

            return Right(response); // return the success response
      },
    );
  }

  // Request for Access Token, Refresh Token, Store Data
  Future<Either<Failure, ResponseAuthenticationModel>> loginDriver(RequestauthenticationFormModel payload) async {
    var result = await _loginServices.loginDriver(payload);
    return result.fold(
          (failure) {
        // Handle failure case
        print("Failed with error: ${failure.toString()}");
        return Left(failure); // return the failure
      },
          (response) async {
        // Perform side effects on success
        await UserStorage.writeTokensToSecureStorage(response.accessToken, response.refreshToken);
        await UserStorage.storeUserData(response);

        return Right(response); // return the success response
      },
    );
  }

  Future<bool> driverLogout() async {
    return UserStorage.clearUserData();
  }

  // Get Companies available for this drivers
  Future<Either<Failure, ResponseGetCompaniesModel>> getCompanies() async {
    return await _loginServices.getCompanies();
  }

  // Request for Access Token, Refresh Token, Store Databased on Company selected
  Future<Either<Failure, ResponseAuthenticationModel>> loginCompany(RequestLoginCompanyModel payload) async {
    var result = await _loginServices.loginCompany(payload);
    return result.fold(
          (failure) {
        // Handle failure case
        print("Failed with error: ${failure.toString()}");
        return Left(failure); // return the failure
      },
          (response) async {
        // Perform side effects on success
        await UserStorage.writeTokensToSecureStorage(response.accessToken, response.refreshToken);
        await UserStorage.storeUserData(response);

        return Right(response); // return the success response
      },
    );
  }
}

