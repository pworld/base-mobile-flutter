import 'package:app_management_system/feature/auth/domain/model/company_list_response_model.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_notifier.dart';
import 'package:app_management_system/feature/auth/presentation/state/company_list_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyListViewNotifier extends StateNotifier<CompanyListViewState> {
  final AuthCompanyListNotifier authCompanyListNotifier;

  CompanyListViewNotifier({required this.authCompanyListNotifier})
      : super(const CompanyListViewState(loading: false));
  
  List<CompanyListResponseModel> getCompanyList() {
    if(authCompanyListNotifier.state.response.data == null) {
      return List<CompanyListResponseModel>.empty();
    }

    return authCompanyListNotifier.state.response.data!;
  }

  void setState({bool? loading}) {
    state = state.copyWith(loading: loading);
  }
}
