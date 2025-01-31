import 'package:app_management_system/core/language/language_popup_menu.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/shared/custom_alert/logout_confirmation_dialog.dart';
import 'package:app_management_system/shared/loading/loading_overlay.dart';
import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_style.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:app_management_system/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../login/presentation/states/login_provider.dart';
import '../../domain/model/profile_domain.dart';
import '../state/profile_provider.dart';

class ProfileScreen extends HookConsumerWidget with LoadingOverlay {
  OverlayEntry? _overlayEntry;

  ProfileScreen({super.key});

  void doLogout(BuildContext context, WidgetRef ref) async {
    final authOtpNotifier = ref.read(authOtpProvider.notifier);
    final authLoginNotifier = ref.read(authLoginProvider.notifier);

    bool success = await ref
        .read(loginDriverStateNotifierProvider.notifier)
        .driverLogout();

    if (success) {
      Navigator.of(context).pop(); // Close the dialog
      context.pushReplacement('/login'); // Navigate to home

      authOtpNotifier.resetState();
      authLoginNotifier.resetState();
      authLoginNotifier.authController.signOut();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                AppLocalizations.of(context)?.translate('logged_out') ??
                    "Logged out successfully!"),
            duration: Duration(seconds: 2)),
      );
    } else {
      // Handle logout failure if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)?.translate('error') ??
                "Logged out failed!"),
            duration: Duration(seconds: 2)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(ProfileNotifierStateProvider);

    print('RENDER');

    // Load Data Transfer Vehicle
    useEffect(() {
      Future.microtask(() {
        ref.read(ProfileNotifierStateProvider.notifier).fetchProfile();
      });

      return () {};
    }, []);

    return SafeArea(
      child: profileData.successData.when(
        data: (data) => _buildContent(context, ref, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Column(children: [
            Text('Error: $error'),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              splashColor: Colors.amber,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => LogoutConfirmationDialog(
                    onSubmitClick: () async {
                      doLogout(context, ref);
                    },
                  ),
                );
              },
              child: Center(
                  child: Text(AppLocalizations.of(context)!.translate('logout'),
                      style: const TextStyle(
                          color: AppColors.raspberry05,
                          fontWeight: FontWeight.w700))),
            ),
          ]);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, ProfileModel data) {
    return Scaffold(
        // TODO: AppBar Need improvement and Adjustment Layout
        // appBar: AppBar(
        //   title: Text('Profil'),
        //   actions: [LanguagePopupMenu()],
        // ),
        body: SafeArea(
            top: true,
            child: Container(
              color: Colors.grey[100], // Light grey background
              // decoration: BoxDecoration(
              //   gradient: const LinearGradient(colors: [
              //     AppColors.kGradientColor1,
              //     AppColors.kGradientColor2,
              //     AppColors.kGradientColor3
              //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              // ),
              child: ListView(
                children: [
                  Container(
                    height: 40,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: const Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [LanguagePopupMenu()],
                    ),
                  ),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.account_circle, size: 80),
                            AppStyle.gapW4,
                            Container(
                              alignment: Alignment.centerLeft,
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data.firstName ?? 'N/A'}',
                                    style: AppText.heading5,
                                  ),
                                  Text(
                                    '${data.phoneNumber ?? 'N/A'}',
                                    style: AppText.textField,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          // padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.raspberry01,
                              border: Border.all(color: AppColors.raspberry01)),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              splashColor: Colors.amber,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        LogoutConfirmationDialog(
                                          onSubmitClick: () async {
                                            doLogout(context, ref);
                                          },
                                        ));
                              },
                              child: Center(
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('logout'),
                                      style: const TextStyle(
                                          color: AppColors.raspberry05,
                                          fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    // decoration: BoxDecoration(color: Colors.amber),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('profile_detail'),
                      style: AppText.heading5,
                    ),
                  ),
                  Container(
                    height: 410,
                    // decoration: BoxDecoration(color: Colors.cyan),
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .translate('firstname'),
                            style: AppText.textField,
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.raisinblack09,
                                // color: AppColors.raisinblack10,
                                border:
                                    Border.all(color: AppColors.raisinblack08),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${data.firstName ?? 'N/A'}',
                                ),
                              )),
                          Text(
                            AppLocalizations.of(context)!.translate('lastname'),
                            style: AppText.textField,
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.raisinblack09,
                                // color: AppColors.raisinblack10,
                                border:
                                    Border.all(color: AppColors.raisinblack08),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${data.lastName ?? 'N/A'}',
                                ),
                              )),
                          Text(
                            AppLocalizations.of(context)!.translate('phone'),
                            style: AppText.textField,
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.raisinblack09,
                                // color: AppColors.raisinblack10,
                                border:
                                    Border.all(color: AppColors.raisinblack08),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(5)),
                                        color: AppColors.raisinblack09),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text('+62'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(data.phoneNumber),
                                    ),
                                  )
                                ],
                              )),
                          const Text(
                            'Email ',
                            style: AppText.textField,
                          ),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              height: 36,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.raisinblack09,
                                // color: AppColors.raisinblack10,
                                border:
                                    Border.all(color: AppColors.raisinblack08),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${data.email ?? 'N/A'}'),
                              )),
                        ]),
                  ),
                ],
              ),
            )));
  }
}
