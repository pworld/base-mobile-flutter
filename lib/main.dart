import 'package:app_management_system/config/environment.dart';
import 'package:app_management_system/core/language/language.dart';
import 'package:app_management_system/core/language/language_repository.dart';
import 'package:app_management_system/root_app.dart';
import 'package:app_management_system/shared/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.filename);

  final container = ProviderContainer();
  final language =
      await container.read(languageRepositoryProvider).getLanguage();

  final location = LocationService();
  location.initialize();

  // FlutterError.onError = (details) {
  //   FlutterError.presentError(details);
  //   if (kReleaseMode) exit(1);
  // };

  runApp(
    ProviderScope(
      overrides: [languageProvider.overrideWith((ref) => language)],
      child: const RootApp(),
    ),
  );
}
