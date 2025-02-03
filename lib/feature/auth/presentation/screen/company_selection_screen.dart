import 'package:app_management_system/feature/auth/domain/model/company_list_response_model.dart';
import 'package:app_management_system/feature/auth/domain/model/company_selection_payload_model.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/company_list_view_provider.dart';
import 'package:app_management_system/shared/custom_button/hyperlink_button.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/loading/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanySelectionScreen extends ConsumerStatefulWidget {
  const CompanySelectionScreen({super.key});

  @override
  ConsumerState<CompanySelectionScreen> createState() =>
      CompanySelectionScreenState();
}

class CompanySelectionScreenState
    extends ConsumerState<CompanySelectionScreen> {
  @override
  void initState() {
    super.initState();

    load();
  }

  Future<void> load() async {
    await Future.delayed(const Duration(milliseconds: 1));

    final companyListNotifier = ref.read(companyListViewProvider.notifier);
    final authCompanyListNotifier = ref.read(authCompanyListProvider.notifier);
    final authLoginNotifier = ref.read(authLoginProvider.notifier);
    final authLogin = ref.read(authLoginProvider);

    if (isEmptyUUID(authLogin.response.data?.tenantId ?? '')) {
      await authCompanyListNotifier.getCompanies();
      companyListNotifier.setState(loading: false);
    } else {
      await authLoginNotifier.saveToken(authLogin.response.data!, true);
      Future.delayed(const Duration(milliseconds: 100), () {
        context.replace('/orders');
      });
    }
  }

  Future<void> onSelect(CompanyListResponseModel tenant) async {
    final companyListNotifier = ref.read(companyListViewProvider.notifier);
    final authCompanyLoginNotifier =
        ref.read(authCompanyLoginProvider.notifier);
    final authCompanyLogin = ref.read(authCompanyLoginProvider);
    final authLoginNotifier = ref.read(authLoginProvider.notifier);
    final authLogin = ref.read(authLoginProvider);

    companyListNotifier.setState(loading: true);

    var payload = CompanySelectionPayloadModel(
      refreshToken: authLogin.response.data!.refreshToken,
      tenantId: tenant.tenantId,
    );

    await authCompanyLoginNotifier.selectCompany(payload);

    companyListNotifier.setState(loading: false);

    Future.delayed(const Duration(milliseconds: 100), () async {
      if (authCompanyLogin.response.data != null) {
        await authLoginNotifier.saveToken(
            authCompanyLogin.response.data!, true);
        Future.delayed(const Duration(milliseconds: 100), () {
          context.replace('/orders');
        });
      } else {
        showSnackbar(context,
            'Gagal memilih perusahaan: ${authCompanyLogin.response.errorMessage}');
      }
    });
  }

  void logout() {
    ref.invalidate(companyListViewProvider);
    ref.invalidate(authLoginProvider);
    ref.invalidate(authOtpProvider);
    context.replace('/login');
  }

  @override
  Widget build(BuildContext context) {
    final companyListNotifier = ref.read(companyListViewProvider.notifier);
    final companyList = ref.watch(companyListViewProvider);
    var list = companyListNotifier.getCompanyList();

    return PopScope(
      canPop: false,
      onPopInvoked: (popped) {
        logout();
      },
      child: Scaffold(
        body: SafeArea(
          child: StatelessLoadingOverlay(
            isLoading: companyList.loading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: companyList.loading
                    ? const SizedBox()
                    : list.isNotEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Silahkan pilih perusahaan',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 512,
                                child: ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Material(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                        elevation: 2,
                                        child: InkWell(
                                          onTap: () => onSelect(list[index]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                              horizontal: 16,
                                            ),
                                            child: Text(
                                              list[index].companyName,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Anda tidak terdaftar di perusahaan manapun. Silahkan hubungi administrator.',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              HyperlinkButton(
                                title: 'Kembali',
                                onTap: () {
                                  logout();
                                },
                              )
                            ],
                          ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
