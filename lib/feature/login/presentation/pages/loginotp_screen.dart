import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_style.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:app_management_system/shared/widgets/phone_country_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app_management_system/locale/app_localization.dart';

import '../../domain/model/login_model.dart';
import '../states/login_provider.dart';

class LoginScreen extends HookConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  LoginScreen({super.key});

  // Visibility Phone Code Control
  bool _showDropdown = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = useState("");
    final phoneCountryCode = useState("ID");

    // Clear storage every time this screen is loaded
    useEffect(() {
      Future<void> clearStorage() async {
        // Perform logout to clear all stored data
        await ref
            .read(loginDriverStateNotifierProvider.notifier)
            .driverLogout();
      }

      clearStorage();
      return null; // Return null when no cleanup is necessary
    }, const []); // Empty dependency array ensures this runs only once per component mount

    // Submit Requests Login OTP
    final loginState = ref.watch(loginOTPStateNotifierProvider);
    useEffect(() {
      loginState.successData.when(
        data: (success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.replace('/logindriver', extra: success);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Your OTP is ${success.otpCode} \n\nThis message is temporary and should not be shown in production.',
                ),
                action: SnackBarAction(
                    label: 'CLOSE',
                    onPressed:
                        ScaffoldMessenger.of(context).hideCurrentSnackBar),
              ),
            );
          });
        },
        loading: () => Container(), // Show loading indicator as needed
        error: (error, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
              ),
            );
          });
        },
      );
      return null; // No cleanup required
    }, [loginState]);

    void handleSubmit() async {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState!.save();
        RequestLoginOTPFormModel requestData = RequestLoginOTPFormModel(
          phoneNumber: phoneNumber.value,
          phoneCountryCode: phoneCountryCode.value,
        );
        // Use LoginStateNotifier to trigger the login process
        await ref
            .read(loginOTPStateNotifierProvider.notifier)
            .loginOTP(requestData);
      }
    }
    // END Submit Requests Login OTP

    return Scaffold(
      backgroundColor: Colors.grey[100],
      // TODO: AppBar Need improvement and Adjustment Layout
      // appBar: AppBar(
      //   title: const Text('Login', style: AppText.heading1),
      // ),

      body: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: AppStyle.formPadding,
          child: ListView(
            children: <Widget>[
              // app Management System - Driver App Texts
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: <Widget>[
                    Text("app Management System", style: AppText.heading1),
                    Text("Driver App", style: AppText.bodyText),
                  ],
                ),
              ),

              // Wrap PhoneCountryDropdown and FormBuilderTextField in a Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex:
                        0, // Adjust flex factor as needed for the dropdown width
                    child: Visibility(
                      visible: _showDropdown,
                      child: PhoneCountryDropdown(
                        onCountryChanged: (country) {
                          phoneCountryCode.value = country.phoneCode;
                          _showDropdown =
                              false; // Hide dropdown after selection
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Spacing between dropdown and text field
                  Expanded(
                    flex:
                        5, // Adjust flex factor as needed for the text field width
                    child: FormBuilderTextField(
                      name: 'phone_number',
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)?.translate(
                              'phone')), // Use your AppStyle.inputDecoration
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Phone number is required'),
                        FormBuilderValidators.numeric(
                            errorText: 'Invalid phone number'),
                      ]),
                      onChanged: (value) {
                        phoneNumber.value = value ??
                            ""; // Update state when phone number changes
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Submit Button
              ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.shadesgray01, // Custom primary color
                  elevation: 5, // Shadow depth, creating a 3D effect
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  shadowColor: Colors.black
                      .withOpacity(0.25), // Shadow color with some transparency
                ),
                child: Text('Login',
                    style: AppText.bodyText.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    ),
  );
}
