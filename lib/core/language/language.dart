import 'package:hooks_riverpod/hooks_riverpod.dart';

enum Language {
  english(flag: '🇬🇧', name: 'English', code: 'en'),
  indonesian(flag: '🇮🇩', name: 'Bahasa', code: 'id');

  const Language({required this.flag, required this.name, required this.code});

  final String flag;
  final String name;
  final String code;
}

final languageProvider = StateProvider<Language>((ref) => Language.english);
