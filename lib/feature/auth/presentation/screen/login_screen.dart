import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_payload_model.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_view_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/otp_timer_provider.dart';
import 'package:app_management_system/shared/custom_button/primary_button.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/loading/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  final form = GlobalKey<FormBuilderState>();
  OTPPayloadModel? payload;

  LoginScreen({
    super.key,
  });

  Future<void> onSubmit(BuildContext context, WidgetRef ref) async {
    if (form.currentState == null) return;
    var formState = form.currentState!;

    if (!formState.validate()) return;
    formState.save();

    payload = OTPPayloadModel(
      phoneNumber: formState.value['phoneNumber'],
      phoneNumberCountryId: 'ID', // TODO: Remove Hardcode
    );

    await ref.read(authOtpProvider.notifier).generateOTP(payload!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ColorScheme color = theme.colorScheme;

    final authOtpState = ref.watch(authOtpProvider);

    // Listening to AuthOTPState changes
    // including form submission
    ref.listen(authOtpProvider, (_, state) {
      if (state.response.status == HTTPStatus.initial) return;
      if (payload == null) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.response.data != null) {
          ref.invalidate(otpTimerProvider);
          context.push('/otp');

          var otpId = state.response.data?.authOtpId;
          var otpCode = state.response.data?.otpCode;

          ref.read(authViewProvider.notifier).set(
                phoneNumber: payload?.phoneNumber,
                phoneNumberCountryCode: payload?.phoneNumberCountryId,
                otpId: otpId,
              );

          showSnackbar(
            context,
            'Your OTP is $otpCode\n\nThis message is temporary and will not be shown in production.',
          );
        } else {
          showSnackbar(context, state.response.errorMessage!);
        }
      });
    });

    return StatelessLoadingOverlay(
      isLoading: authOtpState.loading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          decoration: BoxDecoration(color: color.surfaceContainerHighest),
          child: SafeArea(
            child: FormBuilder(
              key: form,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            const SizedBox(height: 48),
                            const Text(
                              'app Management\nSystem',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Driver App',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Image.asset('assets/images/login-illust.png'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color.onPrimary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Selamat Datang\nKembali!',
                          style: TextStyle(
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Silahkan masuk untuk melanjutkan.',
                          style: TextStyle(
                            color: color.secondary,
                            fontSize: 11.5,
                          ),
                        ),
                        const SizedBox(height: 42),
                        FormBuilderTextField(
                          name: 'phoneNumber',
                          onTapOutside: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          decoration: InputDecoration(
                            labelText: 'Nomor HP',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: color.outline),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: color.outline),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                errorText: 'Nomor hp harus diisi.',
                              ),
                              FormBuilderValidators.numeric(
                                errorText: 'Hanya boleh diisi angka',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: 'Login',
                          onPress: () => onSubmit(context, ref),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
