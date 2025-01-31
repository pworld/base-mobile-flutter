import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/profile_domain.dart';

class ProfileState {
  final AsyncValue<ProfileModel> successData;

  ProfileState({required this.successData});

  ProfileState.initial() : successData = const AsyncValue.loading();

  bool get isLoading => false;
}
