import 'package:dartz/dartz.dart';
import 'package:app_management_system/core/services/failure.dart';
import 'package:app_management_system/shared/services/base_services.dart';

import '../../../login/domain/model/auth_model.dart';
import '../../domain/model/profile_domain.dart';

class ProfileServices extends BaseService {
  // Future for OTP verification
  Future<Either<Failure, ProfileModel>> profile(UserDataModel payload) async {
    return request<ProfileModel>(
      method: 'POST',
      path: 'user-profile',
      payload: payload.toJson(),
      fromJson: (json) => ProfileModel.fromJson(json),
    );
  }
}
