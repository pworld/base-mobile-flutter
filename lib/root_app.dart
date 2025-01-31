import 'package:app_management_system/core/language/language.dart';
import 'package:app_management_system/router/app_router.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'locale/app_localization.dart';

class RootApp extends HookConsumerWidget {
  const RootApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final language = ref.watch(languageProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      title: 'app Management System',

      // Using FlexThemeData for light and dark themes.
      theme: FlexThemeData.light(scheme: FlexScheme.flutterDash, fontFamily: 'Poppins'),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.flutterDash, fontFamily: 'Poppins'),
      themeMode: ThemeMode.light, // Use dark or light theme based on system setting.

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'GB'), // English
        Locale('id', 'ID'), // Indonesia
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: Locale(language.code),
    );
  }
}
