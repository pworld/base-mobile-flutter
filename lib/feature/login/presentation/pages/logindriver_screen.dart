import 'dart:async';

import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_style.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../locale/app_localization.dart';
import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/login_model.dart';
import '../states/login_provider.dart';

class OTPScreen extends HookConsumerWidget {
  var boxNumber = 4;
  final _formKey = GlobalKey<FormBuilderState>();
  final ResponseLoginFormModel otpResponse;

  OTPScreen({super.key, required this.otpResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var otpResponseState = useState(otpResponse);
    final expiresAtUtc = useState(otpResponse.expiresAtUtc);
    final otpCodeForm = useState<List<String>>(List.filled(boxNumber, ''));
    final focusNodes = List.generate(boxNumber, (_) => useFocusNode());

    final otpState = ref.watch(loginDriverStateNotifierProvider);
    final loginState = ref.watch(loginOTPStateNotifierProvider);

    // Using useEffect to handle side effects based on otpState changes
    useEffect(() {
      if (otpState.successData.hasValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (otpState.successData.value?.tenantId ==
              '00000000-0000-0000-0000-000000000000') {
            context.go('/logincompany'); // Navigate on success
          } else {
            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacement('/home'); // Navigate on success
          }
        });
      } else if (otpState.successData.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(otpState.successData.error.toString()),
            ),
          );
        });
      }
      // Handle loading state if necessary
      // }
      return null; // No cleanup needed
    }, [otpState]); // Depend on otpState to re-run side effects

    useEffect(() {
      loginState.successData.when(
        data: (success) {
          otpResponseState.value.phoneNumber = success.phoneNumber;
          otpResponseState.value.phoneCountryCode = success.phoneCountryCode;
          otpResponseState.value.otpId = success.otpId;
        },
        loading: () => Container(), // Show loading indicator as needed
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(
                  error.toString(),
                ),
              ),
            );
          });
        },
      );
      return null; // No cleanup required
    }, [loginState, otpResponseState]);

    // Parsing datetime from API and convert it to int seconds
    final now = DateTime.now();
    final initialDuration = expiresAtUtc.value.difference(now).inSeconds;
    final timerValue =
        useState<int>(initialDuration); // Assuming initialDuration is defined

    useEffect(() {
      // Define the timer variable without initializing it immediately
      Timer? countdownTimer;

      // Initialize the Timer inside a function or the useEffect body
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerValue.value > 0) {
          // Decrement the timer value safely
          timerValue.value = timerValue.value - 1;
        } else {
          // Cancel the timer if the countdown reaches zero
          countdownTimer?.cancel();
        }
      });

      // Return a cleanup function that cancels the timer when the component disposes
      return () {
        countdownTimer?.cancel();
      };
    }, []);

    // Function to focus the next field
    void nextField(
        {required String value,
        required int index,
        required List<String> otpDigits,
        required VoidCallback onCompleted}) {
      if (value.isNotEmpty) {
        if (index < (boxNumber - 1)) {
          focusNodes[index + 1].requestFocus(); // Move focus to next field
        }

        // Update the list with the new value at the specified index
        otpDigits[index] = value;

        // Update the state to reflect the new value in the otpCodeForm
        otpCodeForm.value = List.from(otpDigits);

        // Check if it's the last box and the OTP is complete (all boxes filled)
        if (index == (boxNumber - 1) &&
            otpDigits.every((digit) => digit.isNotEmpty)) {
          // Concatenate all the OTP digits to get the full OTP
          String completeOTP = otpDigits.join();
          // Trigger OTP validation
          onCompleted();
        }
      }
    }

    // Function to submit OTP
    void validateOTP() async {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        // Complete OTP code
        final fullOtpCode = otpCodeForm.value.join();
        RequestauthenticationFormModel requestData =
            RequestauthenticationFormModel(
          phoneNumber: otpResponseState.value.phoneNumber ?? '',
          phoneCountryCode: otpResponseState.value.phoneCountryCode ?? '',
          otpId: otpResponseState.value.otpId,
          otpCode: fullOtpCode,
          userAgent: 'driverapp',
        );
        // Use LoginStateNotifier to trigger the login process
        await ref
            .read(loginDriverStateNotifierProvider.notifier)
            .loginDriver(requestData);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('OTP form validation failed'),
              content: Text('Please check the entered OTP and try again.'),
            ),
          );
        });
      }
    }

    // Refresh the page by setting a new state for `expiresAtUtc`
    void refreshPage() {
      expiresAtUtc.value = DateTime.now()
          .add(Duration(minutes: 2)); // Resetting the expiration time
      timerValue.value = expiresAtUtc.value
          .difference(DateTime.now())
          .inSeconds; // Reset the timer
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      // TODO: AppBar Need improvement and Adjustment Layout
      // appBar: AppBar(
      //   title: const Text('OTP Screen', style: AppText.heading1),
      // ),

      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: AppStyle.formPadding,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: <Widget>[
                    Text("app Management System", style: AppText.heading1),
                    Text("Driver App", style: AppText.bodyText),
                  ],
                ),
              ),

              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  boxNumber,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: 40,
                      child: FormBuilderTextField(
                        name: 'otp_$index',
                        focusNode: focusNodes[index],
                        decoration: AppStyle.inputDecoration,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Required'),
                          FormBuilderValidators.equalLength(1),
                        ]),
                        onChanged: (value) {
                          nextField(
                            value: value!,
                            index: index,
                            otpDigits: otpCodeForm.value,
                            onCompleted: validateOTP,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Conditional Widget based on timer value
              if (timerValue.value > 0)
                Center(
                  child: Text(
                      '${AppLocalizations.of(context)?.translate('timeremaining')} ${timerValue.value} seconds'),
                ),

              // Resend OTP button
              if (timerValue.value <= 0) ...[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '${AppLocalizations.of(context)?.translate('sentotp')}'),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          RequestLoginOTPFormModel requestData =
                              RequestLoginOTPFormModel(
                            phoneNumber:
                                otpResponseState.value.phoneNumber ?? '',
                            phoneCountryCode:
                                otpResponseState.value.phoneCountryCode ?? '',
                          );
                          await ref
                              .read(loginOTPStateNotifierProvider.notifier)
                              .loginOTP(requestData);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.shadesgray01, // Custom primary color
                          elevation: 5, // Shadow depth, creating a 3D effect
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Rounded corners
                          ),
                          shadowColor: Colors.black.withOpacity(
                              0.25), // Shadow color with some transparency
                        ),
                        child: Text(
                            '${AppLocalizations.of(context)?.translate('resend')}',
                            style:
                                AppText.bodyText.copyWith(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
