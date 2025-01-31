import 'package:app_management_system/feature/profile/presentation/state/profile_notifier.dart';
import 'package:app_management_system/feature/profile/presentation/state/profile_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data_access/services/profile_service.dart';
import '../../data_access/usecases/profile_usecase.dart';
import '../../domain/model/profile_domain.dart';

final profileServicesProvider = Provider<ProfileServices>((ref) {
  return ProfileServices();
});

final profileUseCaseProvider = Provider<ProfileUseCase>((ref) {
  return ProfileUseCase(ref.read(profileServicesProvider));
});

final ProfileNotifierStateProvider = StateNotifierProvider<ProfileStateNotifier, ProfileState>((ref) {
  final loginCompanyUseCase = ref.read(profileUseCaseProvider);
  return ProfileStateNotifier(loginCompanyUseCase);
});
