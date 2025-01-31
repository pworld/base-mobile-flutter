import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/company_list_view_notifier.dart';
import 'package:app_management_system/feature/auth/presentation/state/company_list_view_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final companyListViewProvider = StateNotifierProvider<
    CompanyListViewNotifier, CompanyListViewState>(
  (ref) {
    var authCompanyListNotifier = ref.read(authCompanyListProvider.notifier);
    return CompanyListViewNotifier(authCompanyListNotifier: authCompanyListNotifier);
  },
);
