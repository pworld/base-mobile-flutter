import 'package:app_management_system/core/services/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../login/domain/repositories/login_repository.dart';
import '../../domain/model/profile_domain.dart';
import '../services/profile_service.dart';

class ProfileUseCase {
  final ProfileServices _profileServices;

  ProfileUseCase(this._profileServices);

  Future<Either<Failure, ProfileModel>> profile() async {
    final profileJson = await UserStorage.readUserData();  // Read user data

    print('PROFILEJSON');
    print(profileJson);

    if (profileJson == null) {
      // Return an error if no profile data is found
      return Left(ServerFailure(errorMessage: 'No profile data found'));
    }

    var result = await _profileServices.profile(profileJson);
    
    return result.fold(
          (failure) {
        // Return failure from the service directly
        return Left(failure);
      },
          (profileData) {
        // Return the profile data if successful
        return Right(profileData);
      },
    );
  }
}

