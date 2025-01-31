import 'package:app_management_system/core/http/http_enums.dart';
import 'package:app_management_system/feature/auth/domain/model/login_payload_model.dart';
import 'package:app_management_system/feature/auth/domain/model/otp_payload_model.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/auth_view_provider.dart';
import 'package:app_management_system/feature/auth/presentation/provider/otp_timer_provider.dart';
import 'package:app_management_system/shared/custom_button/primary_button.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends ConsumerWidget {
  final form = GlobalKey<FormState>();

  OTPScreen({super.key});

  void resendOTP(BuildContext context, WidgetRef ref) async {
    final authViewState = ref.read(authViewProvider);

    final requestData = OTPPayloadModel(
      phoneNumber: authViewState.phoneNumber!,
      phoneNumberCountryId: authViewState.phoneNumberCountryCode!,
    );

    await ref.read(authOtpProvider.notifier).generateOTP(requestData);

    showSnackbar(
      context,
      'Kode OTP telah dikirim.',
    );
  }

  void handleSubmit(BuildContext context, WidgetRef ref) async {
    var authViewState = ref.read(authViewProvider);

    LoginPayloadModel payload = LoginPayloadModel(
      authOtpId: authViewState.otpId!,
      otpCode: authViewState.otpCode!,
      phoneNumber: authViewState.phoneNumber!,
    );

    await ref.read(authLoginProvider.notifier).login(payload);
  }

  // Reset OTP state and stop the timer
  // when back button is pressed
  void handleBackButton(WidgetRef ref) {
    final otpTimerNotifier = ref.read(otpTimerProvider.notifier);

    if (otpTimerNotifier.isTimerActive()) {
      otpTimerNotifier.stopTimer();
    }

    ref.read(authOtpProvider.notifier).resetState();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    ColorScheme color = theme.colorScheme;

    final textEditingController = TextEditingController();
    final timerState = ref.watch(otpTimerProvider);

    ref.listen(authLoginProvider, (_, state) {
      if (state.response.status == HTTPStatus.initial) return;

      if (state.response.data != null) {
        ref.read(otpTimerProvider.notifier).stopTimer();
        context.go('/companySelection');
      } else {
        showSnackbar(context, state.response.errorMessage!);
      }
    });

    ref.listen(authOtpProvider, (_, state) {
      if (state.response.status == HTTPStatus.initial) return;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        var data = state.response.data;

        if (data != null) {
          ref.read(authViewProvider.notifier).set(otpId: data.authOtpId);

          var countdownValue = data.expiresAtUTC;
          ref.read(otpTimerProvider.notifier).startTimer(countdownValue);
          showSnackbar(
            context,
            'Your OTP is ${data.otpCode}\n\nThis message is temporary and will not be shown in production.',
          );
        }
      });
    });

    return Form(
      key: form,
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          handleBackButton(ref);
          context.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/otp-illust.png'),
                      const Text(
                        'OTP Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      // Text('Enter'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 32,
                        ),
                        child: PinCodeTextField(
                          appContext: context,
                          controller: textEditingController,
                          length: 4,
                          backgroundColor: Colors.transparent,
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            activeBorderWidth: 1,
                            inactiveBorderWidth: 1,
                            selectedBorderWidth: 1,
                            fieldHeight: 60,
                            fieldWidth: 48,
                            activeColor: color.primary,
                            inactiveColor: color.outlineVariant,
                            selectedColor: color.primary,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (pin) => ref
                              .read(authViewProvider.notifier)
                              .set(otpCode: pin),
                          onCompleted: (pin) {
                            handleSubmit(context, ref);
                          },
                        ),
                      ),
                      Text(
                        timerState.timerActive
                            ? timerState.getFormatted()
                            : 'Belum menerima kode OTP?',
                      ),
                      const SizedBox(height: 64)
                    ],
                  ),
                ),
                PrimaryButton(
                  text: 'Resend',
                  onPress: () => resendOTP(context, ref),
                  disabled: timerState.timerActive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
