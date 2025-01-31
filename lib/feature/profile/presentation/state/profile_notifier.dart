import 'package:app_management_system/feature/profile/presentation/state/profile_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data_access/usecases/profile_usecase.dart';

class ProfileStateNotifier extends StateNotifier<ProfileState> {
  final ProfileUseCase _profileUseCase;

  ProfileStateNotifier(this._profileUseCase) : super(ProfileState.initial());

  Future<void> fetchProfile() async {
    state = ProfileState(successData: const AsyncValue.loading());
    final response = await _profileUseCase.profile();
    response.fold(
          (failure) {
        // Handle the failure case, providing both the failure and the current stack trace
        state = ProfileState(successData: AsyncValue.error(failure, StackTrace.current));
      },
          (success) {
        // Handle the success case
        state = ProfileState(successData: AsyncValue.data(success));
      },
    );
  }
}